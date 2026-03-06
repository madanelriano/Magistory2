-- Database Schema for Video Editing SaaS Platform
-- This schema includes all tables and relationships for users, projects, media assets, collaborators, preferences, and templates.

-- Users Table: Stores user information
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'editor', 'viewer')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Projects Table: Stores project information
CREATE TABLE Projects (
    project_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('draft', 'published', 'archived'))
);

-- MediaAssets Table: Stores media assets (video, audio, image)
CREATE TABLE MediaAssets (
    asset_id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES Projects(project_id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    type VARCHAR(10) NOT NULL CHECK (type IN ('video', 'audio', 'image')),
    file_path VARCHAR(255) NOT NULL,
    thumbnail_path VARCHAR(255),
    duration INTEGER, -- Duration in seconds (for video/audio)
    size INTEGER NOT NULL, -- Size in bytes
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ProjectCollaborators Table: Stores project collaborators
CREATE TABLE ProjectCollaborators (
    collaborator_id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES Projects(project_id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL CHECK (role IN ('editor', 'viewer')),
    invited_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    accepted_at TIMESTAMP WITH TIME ZONE
);

-- UserPreferences Table: Stores user preferences
CREATE TABLE UserPreferences (
    preference_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    theme VARCHAR(30) NOT NULL CHECK (theme IN ('dark', 'light', 'modern_professional')),
    default_project_settings JSONB,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Templates Table: Stores project templates
CREATE TABLE Templates (
    template_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    thumbnail_path VARCHAR(255),
    category VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ProjectTemplates Table: Stores relationships between projects and templates
CREATE TABLE ProjectTemplates (
    project_template_id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES Projects(project_id) ON DELETE CASCADE,
    template_id INTEGER NOT NULL REFERENCES Templates(template_id) ON DELETE CASCADE,
    applied_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance optimization
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_projects_user_id ON Projects(user_id);
CREATE INDEX idx_media_assets_project_id ON MediaAssets(project_id);
CREATE INDEX idx_media_assets_user_id ON MediaAssets(user_id);
CREATE INDEX idx_project_collaborators_project_id ON ProjectCollaborators(project_id);
CREATE INDEX idx_project_collaborators_user_id ON ProjectCollaborators(user_id);
CREATE INDEX idx_user_preferences_user_id ON UserPreferences(user_id);
CREATE INDEX idx_templates_category ON Templates(category);
CREATE INDEX idx_project_templates_project_id ON ProjectTemplates(project_id);
CREATE INDEX idx_project_templates_template_id ON ProjectTemplates(template_id);