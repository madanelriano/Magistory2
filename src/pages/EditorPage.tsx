import React from 'react';
import VideoPlayer from '../components/VideoPlayer';
import Timeline from '../components/Timeline';
import Toolbox from '../components/Toolbox';

const EditorPage: React.FC = () => {
  // In a real application, state management for video editing would be here
  // For now, these are just placeholder components

  return (
    <div className="editor-page">
      <h1>Video Editor</h1>
      <div className="editor-layout">
        <div className="editor-main">
          <VideoPlayer />
          <Timeline />
        </div>
        <div className="editor-sidebar">
          <Toolbox />
        </div>
      </div>
    </div>
  );
};

export default EditorPage;
