import React from 'react';

const TextEditor = () => {
  return (
    <div className="text-editor-container">
      {/* Controls for adding and editing text on video */}
      <h3>Text Editor</h3>
      <input type="text" placeholder="Enter text" />
      <button>Add Text</button>
    </div>
  );
};

export default TextEditor;