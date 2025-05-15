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
    </div>
  );
} 