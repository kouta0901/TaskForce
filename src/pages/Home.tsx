import { Link } from 'react-router-dom';

export default function Home() {
  return (
    <div className="app-bg" style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <div className="container">
        <div className="text-center">
          <h1 className="heading-main">
            TaskForce
          </h1>
          <Link
            to="/add"
            className="btn-primary"
            style={{background:'#343434', color:'#fff'}}
          >
            Set Goal
          </Link>
        </div>
      </div>
    </div>
  );
} 