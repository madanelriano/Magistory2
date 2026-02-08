import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import EditorPage from './src/pages/EditorPage';
import './src/styles/global.css';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <Router>
      <Routes>
        <Route path="/" element={<EditorPage />} />
        {/* Add more routes here if needed */}
      </Routes>
    </Router>
  </React.StrictMode>
);