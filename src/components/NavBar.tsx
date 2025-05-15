import { Link } from 'react-router-dom';

export default function NavBar() {
  return (
    <nav className="navbar">
      <div className="navbar-inner">
        <Link to="/active" className="nav-link">
          現在登録されているタスク
        </Link>
        <Link to="/finished" className="nav-link">
          過去に終了したタスク
        </Link>
        <Link to="/settings" className="nav-link">
          設定
        </Link>
      </div>
    </nav>
  );
} 