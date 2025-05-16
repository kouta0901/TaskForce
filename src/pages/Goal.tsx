import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import type { Task } from '../types/task';
import { getTasks } from '../utils/storage';

export default function Goal() {
  const [tasks, setTasks] = useState<Task[]>([]);

  useEffect(() => {
    setTasks(getTasks());
  }, []);

  const activeTasks = tasks.filter(task => !task.done);
  const finishedTasks = tasks.filter(task => task.done);

  return (
    <div className="app-bg">
      <div className="container">
        <h2 className="heading-main">Overview</h2>
        <div className="task-grid">
          {activeTasks.map(task => (
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
          {finishedTasks.map(task => (
            <Link
              key={task.id}
              to={`/task/${task.id}`}
              className="task-card finished"
              style={{ color: '#aaa', textDecoration: 'line-through', opacity: 0.5 }}
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
            タスクはありません
          </p>
        )}
      </div>
    </div>
  );
} 