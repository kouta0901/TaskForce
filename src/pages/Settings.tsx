import { useState, useEffect } from 'react';
import { clearTasks } from '../utils/storage';

export default function Settings() {
  const [notifications, setNotifications] = useState('enabled');
  const [reminderCount, setReminderCount] = useState(3);

  useEffect(() => {
    // 通知の許可状態を確認
    if (Notification.permission !== 'granted') {
      setNotifications('disabled');
    }
    // 通知回数の初期値をlocalStorageから取得
    const saved = localStorage.getItem('reminderCount');
    if (saved) setReminderCount(Number(saved));
  }, []);

  useEffect(() => {
    localStorage.setItem('reminderCount', String(reminderCount));
  }, [reminderCount]);

  const handleNotificationChange = async (e: React.ChangeEvent<HTMLSelectElement>) => {
    const value = e.target.value;
    if (value === 'enabled') {
      const permission = await Notification.requestPermission();
      if (permission === 'granted') {
        setNotifications('enabled');
        alert('通知を有効にしました。');
      } else {
        alert('通知の許可が必要です。ブラウザの設定から許可してください。');
      }
    } else {
      setNotifications('disabled');
      alert('通知を一時的に停止しました。');
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
        <h2 className="heading-main">Setting</h2>
        <div className="form-group">
          <div style={{display: 'flex', flexDirection: 'column', alignItems: 'center', width: '100%'}}>
            <h3 className="form-label" style={{textAlign: 'center'}}>通知を一時的に停止</h3>
            <select value={notifications} onChange={handleNotificationChange} className="form-input" style={{maxWidth: 140, marginTop: 8, textAlign: 'center'}}>
              <option value="enabled">有効</option>
              <option value="disabled">一時停止</option>
            </select>
          </div>
        </div>
        <div className="form-group">
          <label className="form-label">デフォルト通知回数</label>
          <select
            value={reminderCount}
            onChange={e => setReminderCount(Number(e.target.value))}
            className="form-input"
            style={{maxWidth: 140}}
          >
            {[3,4,5,6,7,8,9].map(n => (
              <option key={n} value={n}>{n} 回</option>
            ))}
          </select>
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