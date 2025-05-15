import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import type { Task } from '../types/task';
import { getTasks } from '../utils/storage';

export default function ActiveTasks() {
  const [tasks, setTasks] = useState<Task[]>([]);

  useEffect(() => {
    const allTasks = getTasks();
    const activeTasks = allTasks.filter(task => !task.done);
    setTasks(activeTasks);
  }, []);

  return (
    <div className="app-bg">
      <div className="container">
        <h2 className="heading-main">現在登録されているタスク</h2>
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
            現在登録されているタスクはありません
          </p>
        )}
      </div>
    </div>
  );
} 