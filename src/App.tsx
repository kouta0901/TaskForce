import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { useReminders } from './hooks/useReminders';
import Home from './pages/Home';
import AddTask from './pages/AddTask';
import ActiveTasks from './pages/ActiveTasks';
import FinishedTasks from './pages/FinishedTasks';
import TaskDetail from './pages/TaskDetail';
import Settings from './pages/Settings';
import './App.css'

function App() {
  // リマインダーの監視を開始
  useReminders();

  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/add" element={<AddTask />} />
        <Route path="/active" element={<ActiveTasks />} />
        <Route path="/finished" element={<FinishedTasks />} />
        <Route path="/task/:id" element={<TaskDetail />} />
        <Route path="/settings" element={<Settings />} />
      </Routes>
    </Router>
  );
}

export default App;
