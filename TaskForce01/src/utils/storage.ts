import type { Task } from '../types/task';

const STORAGE_KEY = 'taskforce_tasks';

export const getTasks = (): Task[] => {
  const tasks = localStorage.getItem(STORAGE_KEY);
  return tasks ? JSON.parse(tasks) : [];
};

export const saveTasks = (tasks: Task[]): void => {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(tasks));
};

export const addTask = (task: Task): void => {
  const tasks = getTasks();
  tasks.push(task);
  saveTasks(tasks);
};

export const updateTask = (updatedTask: Task): void => {
  const tasks = getTasks();
  const index = tasks.findIndex(task => task.id === updatedTask.id);
  if (index !== -1) {
    tasks[index] = updatedTask;
    saveTasks(tasks);
  }
};

export const deleteTask = (taskId: string): void => {
  const tasks = getTasks();
  const filteredTasks = tasks.filter(task => task.id !== taskId);
  saveTasks(filteredTasks);
};

export function clearTasks(): void {
  localStorage.removeItem(STORAGE_KEY);
} 