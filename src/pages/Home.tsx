import { Link } from 'react-router-dom';

export default function Home() {
  return (
    <div className="app-bg">
      <div className="container">
        <div className="text-center">
          <h1 className="heading-main">
            TaskForce
          </h1>
          <Link
            to="/add"
            className="btn-primary"
          >
            タスクを登録する
          </Link>
        </div>
      </div>

      {/* 固定ナビゲーションバー */}
      <nav className="navbar">
        <div className="navbar-inner">
          <Link
            to="/active"
            className="nav-link"
          >
            現在登録されているタスク
          </Link>
          <Link
            to="/finished"
            className="nav-link"
          >
            過去に終了したタスク
          </Link>
          <Link
            to="/settings"
            className="nav-link"
          >
            設定
          </Link>
        </div>
      </nav>
    </div>
  );
} 