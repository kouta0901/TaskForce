import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import type { Task } from '../types/task';
import { getTasks, updateTask } from '../utils/storage';

export default function TaskDetail() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [task, setTask] = useState<Task | null>(null);
  const [title, setTitle] = useState('');
  const [detail, setDetail] = useState('');
  const [due, setDue] = useState('');

  useEffect(() => {
    const tasks = getTasks();
    const foundTask = tasks.find(t => t.id === id);
    if (foundTask) {
      setTask(foundTask);
      setTitle(foundTask.title);
      setDetail(foundTask.detail);
      setDue(new Date(foundTask.due).toISOString().slice(0, 16));
    } else {
      navigate('/');
    }
  }, [id, navigate]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!task) return;

    const updatedTask: Task = {
      ...task,
      title,
      detail,
      due: new Date(due).toISOString(),
    };

    updateTask(updatedTask);
    navigate('/');
  };

  const toggleDone = () => {
    if (!task) return;

    const updatedTask: Task = {
      ...task,
      done: !task.done,
    };

    updateTask(updatedTask);
    navigate('/');
  };

  if (!task) return null;

  // 残り通知回数（未来のreminders数）
  const now = new Date();
  const remainingReminders = task.reminders.filter(r => new Date(r) > now).length;

  return (
    <div style={{position: 'fixed', top:0, left:0, width:'100vw', height:'100vh', background:'rgba(0,0,0,0.3)', zIndex:2000, display:'flex', alignItems:'center', justifyContent:'center'}}>
      <div style={{background:'#fff', color:'#222', borderRadius:16, boxShadow:'0 4px 32px rgba(0,0,0,0.18)', padding:32, minWidth:320, maxWidth:400, width:'90%', position:'relative'}}>
        <button onClick={()=>navigate(-1)} style={{position:'absolute', top:16, left:16, background:'none', border:'none', fontSize:24, cursor:'pointer', color:'#888'}} aria-label="閉じる">×</button>
        <h2 className="heading-main" style={{color:'#222', textAlign:'center'}}>Goalの詳細</h2>
        <div style={{textAlign:'center', marginBottom:16, fontWeight:'bold'}}>残り通知回数: {remainingReminders}回</div>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="title" className="form-label" style={{color:'#222'}}>
              タイトル
            </label>
            <input
              type="text"
              id="title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="form-input"
              required
              style={{color:'#fff'}}
            />
          </div>

          <div className="form-group">
            <label htmlFor="detail" className="form-label" style={{color:'#222'}}>
              詳細
            </label>
            <textarea
              id="detail"
              value={detail}
              onChange={(e) => setDetail(e.target.value)}
              className="form-input"
              rows={4}
              style={{color:'#fff'}}
            />
          </div>

          <div className="form-group">
            <label htmlFor="due" className="form-label" style={{color:'#222'}}>
              期限
            </label>
            <input
              type="datetime-local"
              id="due"
              value={due}
              onChange={(e) => setDue(e.target.value)}
              className="form-input"
              required
              style={{color:'#fff'}}
            />
          </div>

          <div style={{display:'flex', justifyContent:'space-between', marginTop:32}}>
            <button type="submit" style={{background:'#343434', color:'#fff', border:'none', borderRadius:8, padding:'12px 24px', fontWeight:'bold', fontSize:16, minWidth:100}}>
              保存
            </button>
            <button
              type="button"
              onClick={toggleDone}
              style={{background:'#343434', color:'#fff', border:'none', borderRadius:8, padding:'12px 24px', fontWeight:'bold', fontSize:16, minWidth:100}}
            >
              {task.done ? '未完了に戻す' : '完了にする'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
} 