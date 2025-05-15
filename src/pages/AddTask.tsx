import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { addTask } from '../utils/storage';
import { generateReminders } from '../utils/reminders';

export default function AddTask() {
  const navigate = useNavigate();
  const [title, setTitle] = useState('');
  const [detail, setDetail] = useState('');
  const [due, setDue] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!title || !due) return;

    const dueDate = new Date(due);
    if (dueDate < new Date()) {
      alert('期限は現在時刻より後の日時を指定してください');
      return;
    }

    const reminders = generateReminders(dueDate);
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
        <h2 className="heading-main">タスクを登録</h2>
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
              type="datetime-local"
              id="due"
              value={due}
              onChange={(e) => setDue(e.target.value)}
              className="form-input"
              required
            />
          </div>

          <button type="submit" className="btn-primary">
            登録
          </button>
        </form>
      </div>
    </div>
  );
} 