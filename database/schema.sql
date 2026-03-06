-- Database Schema for Video Project Management System
-- This schema defines all tables and relationships for the application

-- Users table to store user information
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP WITH TIME ZONE
);

-- Projects table to store video project metadata
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    project_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    resolution VARCHAR(20) DEFAULT '1080p',
    fps INTEGER DEFAULT 30,
    duration INTEGER DEFAULT 0, -- Duration in seconds
    
    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- Media assets table to store information about media files
CREATE TABLE media_assets (
    asset_id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL,
    asset_type VARCHAR(20) NOT NULL CHECK (asset_type IN ('video', 'audio', 'image')),
    file_path VARCHAR(255) NOT NULL,
    file_name VARCHAR(100) NOT NULL,
    duration INTEGER, -- Duration in seconds (NULL for images)
    thumbnail_path VARCHAR(255),
    
    CONSTRAINT fk_project
        FOREIGN KEY (project_id)
        REFERENCES projects(project_id)
        ON DELETE CASCADE
);

-- Timeline table to store the structure of the video project
CREATE TABLE timeline (
    timeline_id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL,
    track_number INTEGER NOT NULL,
    asset_id INTEGER,
    start_time INTEGER NOT NULL, -- Start time in seconds
    end_time INTEGER NOT NULL, -- End time in seconds
    effects JSONB,
    transitions JSONB,
    
    CONSTRAINT fk_project_timeline
        FOREIGN KEY (project_id)
        REFERENCES projects(project_id)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_asset
        FOREIGN KEY (asset_id)
        REFERENCES media_assets(asset_id)
        ON DELETE SET NULL
);

-- User preferences table to store user-specific settings
CREATE TABLE user_preferences (
    preference_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    theme VARCHAR(20) DEFAULT 'Modern & Minimalist',
    default_resolution VARCHAR(20) DEFAULT '1080p',
    auto_save_interval INTEGER DEFAULT 120, -- Interval in seconds
    
    CONSTRAINT fk_user_preferences
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- Indexes for performance optimization
CREATE INDEX idx_projects_user_id ON projects(user_id);
CREATE INDEX idx_media_assets_project_id ON media_assets(project_id);
CREATE INDEX idx_timeline_project_id ON timeline(project_id);
CREATE INDEX idx_timeline_asset_id ON timeline(asset_id);
CREATE INDEX idx_user_preferences_user_id ON user_preferences(user_id);