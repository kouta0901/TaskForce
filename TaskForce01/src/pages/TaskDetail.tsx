import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import type { Task } from '../types/task';
import { getTasks, updateTask } from '../utils/storage';

export default function TaskDetail() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [task, setTask] = useState<Task | null>(null);
  const [title, setTitle] = useState('');
  const [detail, setDetail] = useState('');
  const [due, setDue] = useState('');

  useEffect(() => {
    const tasks = getTasks();
    const foundTask = tasks.find(t => t.id === id);
    if (foundTask) {
      setTask(foundTask);
      setTitle(foundTask.title);
      setDetail(foundTask.detail);
      setDue(new Date(foundTask.due).toISOString().slice(0, 16));
    } else {
      navigate('/');
    }
  }, [id, navigate]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!task) return;

    const updatedTask: Task = {
      ...task,
      title,
      detail,
      due: new Date(due).toISOString(),
    };

    updateTask(updatedTask);
    navigate('/');
  };

  const toggleDone = () => {
    if (!task) return;

    const updatedTask: Task = {
      ...task,
      done: !task.done,
    };

    updateTask(updatedTask);
    navigate('/');
  };

  if (!task) return null;

  return (
    <div className="app-bg">
      <div className="form-container">
        <h2 className="heading-main">タスクの詳細</h2>
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

          <div className="form-actions">
            <button type="submit" className="btn-primary">
              保存
            </button>
            <button
              type="button"
              onClick={toggleDone}
              className={task.done ? "btn-secondary" : "btn-primary"}
            >
              {task.done ? '未完了に戻す' : '完了にする'}
            </button>
            <button
              type="button"
              onClick={() => navigate('/')}
              className="btn-secondary"
            >
              戻る
            </button>
          </div>
        </form>
      </div>
    </div>
  );
} 