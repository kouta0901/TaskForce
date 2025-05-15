import { useState, useEffect } from 'react';
import { clearTasks } from '../utils/storage';

export default function Settings() {
  const [notifications, setNotifications] = useState(false);
  const [darkMode, setDarkMode] = useState(false);

  useEffect(() => {
    // 通知の許可状態を確認
    if (Notification.permission === 'granted') {
      setNotifications(true);
    }

    // ダークモードの設定を確認
    const isDarkMode = localStorage.getItem('darkMode') === 'true';
    setDarkMode(isDarkMode);
    if (isDarkMode) {
      document.documentElement.classList.add('dark');
    }
  }, []);

  const handleNotificationToggle = async () => {
    if (!notifications) {
      const permission = await Notification.requestPermission();
      if (permission === 'granted') {
        setNotifications(true);
        alert('通知が許可されました。通知を無効にする場合は、ブラウザの設定から変更してください。');
      }
    } else {
      setNotifications(false);
      alert('通知を無効にするには、ブラウザの設定から変更してください。');
    }
  };

  const handleDarkModeToggle = () => {
    const newDarkMode = !darkMode;
    setDarkMode(newDarkMode);
    localStorage.setItem('darkMode', String(newDarkMode));
    if (newDarkMode) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  };

  const handleClearData = () => {
    if (window.confirm('すべてのデータを削除しますか？この操作は取り消せません。')) {
      clearTasks();
      alert('データを削除しました');
    }
  };

  return (
    <div className="app-bg">
      <div className="form-container">
        <h2 className="heading-main">設定</h2>
        <div className="form-group">
          <div className="form-actions">
            <div>
              <h3 className="form-label">通知</h3>
              <p className="task-due">
                タスクの期限が近づいたときに通知を受け取ります
              </p>
            </div>
            <button
              type="button"
              onClick={handleNotificationToggle}
              className={notifications ? "btn-secondary" : "btn-primary"}
            >
              {notifications ? '通知を無効にする' : '通知を有効にする'}
            </button>
          </div>
        </div>

        <div className="form-group">
          <div className="form-actions">
            <div>
              <h3 className="form-label">ダークモード</h3>
              <p className="task-due">
                画面の色を暗くして目に優しくします
              </p>
            </div>
            <button
              type="button"
              onClick={handleDarkModeToggle}
              className={darkMode ? "btn-secondary" : "btn-primary"}
            >
              {darkMode ? 'ダークモードをオフ' : 'ダークモードをオン'}
            </button>
          </div>
        </div>

        <button
          type="button"
          onClick={handleClearData}
          className="btn-danger"
        >
          すべてのデータを削除
        </button>
      </div>
    </div>
  );
} 