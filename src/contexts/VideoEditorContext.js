import React, { createContext, useState, useContext } from 'react';

const VideoEditorContext = createContext();

export const VideoEditorProvider = ({ children }) => {
  const [videoFile, setVideoFile] = useState(null);
  const [timeline, setTimeline] = useState([]); // Array of video segments/clips
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0); // Current playback time
  const [duration, setDuration] = useState(0); // Total video duration
  const [zoomLevel, setZoomLevel] = useState(1); // Timeline zoom level

  const value = {
    videoFile,
    setVideoFile,
    timeline,
    setTimeline,
    isPlaying,
    setIsPlaying,
    currentTime,
    setCurrentTime,
    duration,
    setDuration,
    zoomLevel,
    setZoomLevel,
  };

  return (
    <VideoEditorContext.Provider value={value}>
      {children}
    </VideoEditorContext.Provider>
  );
};

export const useVideoEditor = () => {
  const context = useContext(VideoEditorContext);
  if (!context) {
    throw new Error('useVideoEditor must be used within a VideoEditorProvider');
  }
  return context;
};
