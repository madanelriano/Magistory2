import React from 'react';
import VideoPlayer from '../components/VideoPlayer';
import Timeline from '../components/Timeline';
import Controls from '../components/Controls';
import Toolbar from '../components/Toolbar';
import { useVideoEditor } from '../contexts/VideoEditorContext';

const EditorPage = () => {
  const { videoFile, setVideoFile } = useVideoEditor();

  const handleFileChange = (event) => {
    const file = event.target.files[0];
    if (file && file.type.startsWith('video/')) {
      setVideoFile(file);
    } else {
      alert('Please upload a valid video file.');
    }
  };

  return (
    <div className="video-editor-container">
      <h1>Video Editor</h1>
      <div className="toolbar-section">
        <Toolbar />
        <input type="file" accept="video/*" onChange={handleFileChange} />
      </div>
      <div className="main-editor-section">
        <VideoPlayer />
        <div className="editor-controls">
          <Controls />
        </div>
      </div>
      <div className="timeline-section">
        <Timeline />
      </div>
    </div>
  );
};

export default EditorPage;
