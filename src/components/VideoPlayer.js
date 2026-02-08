import React from 'react';

const VideoPlayer = () => {
  return (
    <div className="video-player-container">
      {/* Video player goes here */}
      <video controls className="video-player">
        Your browser does not support the video tag.
      </video>
    </div>
  );
};

export default VideoPlayer;