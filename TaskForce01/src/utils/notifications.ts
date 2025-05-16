export const requestNotificationPermission = async (): Promise<boolean> => {
  if (!('Notification' in window)) {
    console.warn('このブラウザは通知をサポートしていません');
    return false;
  }

  const permission = await Notification.requestPermission();
  return permission === 'granted';
};

export const showNotification = (title: string, options?: NotificationOptions): void => {
  if (!('Notification' in window) || Notification.permission !== 'granted') {
    // 通知が許可されていない場合はアラートで代替
    alert(title);
    return;
  }

  new Notification(title, options);
}; 