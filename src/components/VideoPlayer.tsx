import React from 'react';

const VideoPlayer: React.FC = () => {
  return (
    <div className="video-player">
      {/* Placeholder for video element */}
      <video controls width="100%" height="auto">
        <source src="" type="video/mp4" />
        Your browser does not support the video tag.
      </video>
    </div>
  );
};

export default VideoPlayer;
