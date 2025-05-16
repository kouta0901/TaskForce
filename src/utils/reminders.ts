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

export function generateSmartReminders(
  deadline: Date,
  count = 3,
  minGapRatio = 0.3,
  maxTrials = 100
): string[] {
  const now = Date.now();
  const end = deadline.getTime();
  if (end <= now) return [];

  const total = end - now;
  const minGap = (total / (count + 1)) * minGapRatio;
  const reminders: number[] = [];

  while (reminders.length < count && maxTrials-- > 0) {
    const cand = now + Math.random() * total;
    if (reminders.every(ts => Math.abs(ts - cand) >= minGap)) {
      reminders.push(cand);
    }
  }
  // 足りなければ minGap 無視で埋める（安全弁）
  while (reminders.length < count) {
    reminders.push(now + Math.random() * total);
  }

  return reminders.sort().map(ts => new Date(ts).toISOString());
} 