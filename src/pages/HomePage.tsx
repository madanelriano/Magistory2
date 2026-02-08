import React from 'react';
import { Link } from 'react-router-dom';

const HomePage: React.FC = () => {
  return (
    <div className="home-page">
      <h1>Welcome to Video Editor</h1>
      <p>Start editing your videos with ease.</p>
      <Link to="/editor">
        <button>Go to Editor</button>
      </Link>
    </div>
  );
};

export default HomePage;
