import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { addTask } from '../utils/storage';
import { generateSmartReminders } from '../utils/reminders';

export default function AddTask() {
  const navigate = useNavigate();
  const defaultReminderCount = Number(localStorage.getItem('reminderCount')) || 3;
  const [title, setTitle] = useState('');
  const [detail, setDetail] = useState('');
  const [due, setDue] = useState('');
  const [reminderCount, setReminderCount] = useState(defaultReminderCount);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!title || !due) return;

    const dueDate = new Date(due);
    if (dueDate < new Date()) {
      alert('期限は現在時刻より後の日時を指定してください');
      return;
    }

    const reminders = generateSmartReminders(dueDate, reminderCount);
    addTask({
      id: Date.now().toString(),
      title,
      detail,
      due: dueDate.toISOString(),
      reminders,
      done: false,
    });

    navigate('/');
  };

  return (
    <div className="app-bg">
      <div className="form-container">
        <h2 className="heading-main">Set a Goal</h2>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="title" className="form-label">
              タイトル
            </label>
            <input
              type="text"
              id="title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="form-input"
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="detail" className="form-label">
              詳細
            </label>
            <textarea
              id="detail"
              value={detail}
              onChange={(e) => setDetail(e.target.value)}
              className="form-input"
              rows={4}
            />
          </div>

          <div className="form-group">
            <label htmlFor="due" className="form-label">
              期限
            </label>
            <input
              type="date"
              id="due"
              value={due}
              onChange={(e) => setDue(e.target.value)}
              className="form-input"
              required
            />
          </div>

          <div className="form-group">
            <label className="form-label">通知回数</label>
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

          <button type="submit" className="btn-primary" style={{background:'#343434', color:'#fff'}}>Set</button>
        </form>
      </div>
    </div>
  );
} 