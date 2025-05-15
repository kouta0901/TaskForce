export interface Task {
  id: string;          // uuid
  title: string;
  detail: string;
  due: string;         // ISO string
  reminders: string[]; // 3 ISO strings, random between now and due
  done: boolean;
} 