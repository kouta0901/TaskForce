export const generateRandomReminders = (dueDate: string, count: number = 3): string[] => {
  const now = new Date();
  const due = new Date(dueDate);
  
  if (due <= now) {
    throw new Error('期限は現在時刻より後の日時を指定してください');
  }

  const timeRange = due.getTime() - now.getTime();
  const reminders: string[] = [];

  for (let i = 0; i < count; i++) {
    // ランダムな時間を生成（現在時刻から期限までの間）
    const randomTime = now.getTime() + Math.random() * timeRange;
    reminders.push(new Date(randomTime).toISOString());
  }

  // 時間順にソート
  return reminders.sort();
};

export function generateReminders(dueDate: Date): string[] {
  const reminders: string[] = [];
  const now = new Date();
  const diff = dueDate.getTime() - now.getTime();
  const hours = Math.floor(diff / (1000 * 60 * 60));
  if (hours > 24) {
    reminders.push(new Date(dueDate.getTime() - 24 * 60 * 60 * 1000).toISOString());
  }
  if (hours > 1) {
    reminders.push(new Date(dueDate.getTime() - 60 * 60 * 1000).toISOString());
  }
  reminders.push(new Date(dueDate.getTime() - 30 * 60 * 1000).toISOString());
  return reminders;
} 