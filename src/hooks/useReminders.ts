import { useEffect, useRef } from 'react';
import { getTasks } from '../utils/storage';
import { showNotification } from '../utils/notifications';

export function useReminders() {
  const timeoutsRef = useRef<number[]>([]);

  useEffect(() => {
    // 既存のタイムアウトをクリア
    timeoutsRef.current.forEach(timeout => clearTimeout(timeout));
    timeoutsRef.current = [];

    const tasks = getTasks();
    const now = new Date();

    tasks.forEach(task => {
      if (task.done) return; // 完了済みのタスクはスキップ

      task.reminders.forEach(reminderTime => {
        const reminderDate = new Date(reminderTime);
        if (reminderDate > now) {
          const timeout = setTimeout(() => {
            showNotification(task.title, {
              body: `期限: ${new Date(task.due).toLocaleString()}`,
              icon: '/favicon.ico',
            });
          }, reminderDate.getTime() - now.getTime());

          timeoutsRef.current.push(timeout);
        }
      });
    });

    // クリーンアップ関数
    return () => {
      timeoutsRef.current.forEach(timeout => clearTimeout(timeout));
    };
  }, []); // コンポーネントのマウント時にのみ実行
} 