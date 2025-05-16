import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import type { Task } from '../types/task';
import { getTasks } from '../utils/storage';

export default function FinishedTasks() {
  const [tasks, setTasks] = useState<Task[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    const allTasks = getTasks();
    const finishedTasks = allTasks.filter(task => task.done);
    setTasks(finishedTasks);
  }, []);

  return (
    <div className="app-bg">
      <div className="container">
        <button
          className="btn-secondary"
          style={{ marginBottom: '24px' }}
          onClick={() => navigate('/')}
        >
          戻る
        </button>
        <h2 className="heading-main">過去に終了したタスク</h2>
        <div className="task-grid">
          {tasks.map(task => (
            <Link
              key={task.id}
              to={`/task/${task.id}`}
              className="task-card"
            >
              <h3 className="task-title">{task.title}</h3>
              <p className="task-due">
                期限: {new Date(task.due).toLocaleString()}
              </p>
            </Link>
          ))}
        </div>
        {tasks.length === 0 && (
          <p className="task-empty">
            過去に終了したタスクはありません
          </p>
        )}
      </div>
    </div>
  );
} 