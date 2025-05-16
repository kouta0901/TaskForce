import { Link, useLocation } from 'react-router-dom';
import { FaHome, FaBullseye, FaCog } from 'react-icons/fa';
import './NavBar.css';

export default function NavBar() {
  const location = useLocation();
  return (
    <nav className="menu-bar">
      <Link to="/" className={`menu-item${location.pathname === '/' ? ' active' : ''}`}> 
        <FaHome size={24} />
        <span>Home</span>
      </Link>
      <Link to="/goal" className={`menu-item${location.pathname === '/goal' ? ' active' : ''}`}> 
        <FaBullseye size={24} />
        <span>Goal</span>
      </Link>
      <Link to="/settings" className={`menu-item${location.pathname === '/settings' ? ' active' : ''}`}> 
        <FaCog size={24} />
        <span>Setting</span>
      </Link>
    </nav>
  );
} 