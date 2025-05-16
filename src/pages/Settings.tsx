import { useState, useEffect } from 'react';
import { clearTasks } from '../utils/storage';

export default function Settings() {
  const [notifications, setNotifications] = useState('通知する');
  const [reminderCount, setReminderCount] = useState(3);
  const [showConfirm, setShowConfirm] = useState(false);

  useEffect(() => {
    // 通知の許可状態を確認
    if (Notification.permission !== 'granted') {
      setNotifications('一時停止');
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
    setNotifications(value);
    if (value === '一時停止') {
      // 通知をオフ
      if (Notification.permission === 'granted') {
        alert('通知を一時的に停止しました。ブラウザの設定から通知を再度有効にできます。');
      }
    } else {
      // 通知をオン
      const permission = await Notification.requestPermission();
      if (permission === 'granted') {
        alert('通知を有効にしました。');
      } else {
        alert('通知の許可が必要です。ブラウザの設定から許可してください。');
      }
    }
  };

  const handleClearData = () => {
    setShowConfirm(true);
  };

  const handleConfirm = (yes: boolean) => {
    setShowConfirm(false);
    if (yes) {
      clearTasks();
      alert('すべてのGoalを削除しました');
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
              <option value="一時停止" style={{textAlign:'center'}}>一時停止</option>
              <option value="通知する" style={{textAlign:'center'}}>通知する</option>
            </select>
          </div>
        </div>
        <div className="form-group">
          <label className="form-label">デフォルト通知回数</label>
          <select
            value={reminderCount}
            onChange={e => setReminderCount(Number(e.target.value))}
            className="form-input"
            style={{maxWidth: 140, textAlign:'center'}}
          >
            {[3,4,5,6,7,8,9].map(n => (
              <option key={n} value={n} style={{textAlign:'center'}}>{n} 回</option>
            ))}
          </select>
        </div>
        <button
          type="button"
          onClick={handleClearData}
          className="btn-danger"
        >
          すべてのGoalを削除
        </button>
      </div>
      {showConfirm && (
        <div style={{position:'fixed', top:0, left:0, width:'100vw', height:'100vh', background:'rgba(0,0,0,0.3)', zIndex:2000, display:'flex', alignItems:'center', justifyContent:'center'}}>
          <div style={{background:'#fff', color:'#222', borderRadius:16, boxShadow:'0 4px 32px rgba(0,0,0,0.18)', padding:32, minWidth:320, maxWidth:400, width:'90%', position:'relative', display:'flex', flexDirection:'column', justifyContent:'center', alignItems:'center'}}>
            <div style={{fontWeight:'bold', fontSize:20, marginBottom:32, textAlign:'center'}}>あなたは人生を諦めるのですか？</div>
            <div style={{display:'flex', justifyContent:'space-between', width:'100%', marginTop:32}}>
              <button onClick={()=>handleConfirm(false)} style={{background:'#343434', color:'#fff', border:'none', borderRadius:8, padding:'12px 24px', fontWeight:'bold', fontSize:16, minWidth:100, marginRight:'auto'}}>いいえ</button>
              <button onClick={()=>handleConfirm(true)} style={{background:'#343434', color:'#fff', border:'none', borderRadius:8, padding:'12px 24px', fontWeight:'bold', fontSize:16, minWidth:100, marginLeft:'auto'}}>はい</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
} 