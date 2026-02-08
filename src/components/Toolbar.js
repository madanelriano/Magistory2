import React from 'react';

const Toolbar = () => {
  return (
    <div className="toolbar-container">
      {/* Editing tools: Cut, Trim, Effects, Text, Audio */}
      <button>Cut</button>
      <button>Trim</button>
      <button>Effects</button>
      <button>Text</button>
      <button>Audio</button>
    </div>
  );
};

export default Toolbar;