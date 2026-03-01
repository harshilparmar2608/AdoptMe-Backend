-- Users table
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(255),
  user_type VARCHAR(50),
  profile_picture_url VARCHAR(255),
  eco_credits INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trees table
CREATE TABLE IF NOT EXISTS trees (
  id SERIAL PRIMARY KEY,
  tree_id VARCHAR(50) UNIQUE NOT NULL,
  species_name VARCHAR(255) NOT NULL,
  common_name VARCHAR(255),
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  zone_name VARCHAR(255),
  planting_date DATE,
  height_ft DECIMAL(5, 2),
  age_years INT,
  health_status VARCHAR(50),
  vitality_score INT,
  moisture_level VARCHAR(50),
  pest_status VARCHAR(50),
  sequestration_lbs_yr DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Adoptions table
CREATE TABLE IF NOT EXISTS adoptions (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  tree_id INT NOT NULL REFERENCES trees(id) ON DELETE CASCADE,
  adoption_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Health Reports table
CREATE TABLE IF NOT EXISTS health_reports (
  id SERIAL PRIMARY KEY,
  tree_id INT NOT NULL REFERENCES trees(id) ON DELETE CASCADE,
  user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  report_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  photo_url VARCHAR(255),
  ai_analysis TEXT,
  health_metrics JSONB,
  verified BOOLEAN DEFAULT FALSE,
  verified_by INT REFERENCES users(id),
  verification_date TIMESTAMP,
  eco_credits_awarded INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Care Logs table
CREATE TABLE IF NOT EXISTS care_logs (
  id SERIAL PRIMARY KEY,
  tree_id INT NOT NULL REFERENCES trees(id) ON DELETE CASCADE,
  user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  care_type VARCHAR(100),
  log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  photo_urls TEXT[],
  notes TEXT,
  verified BOOLEAN DEFAULT FALSE,
  verified_by INT REFERENCES users(id),
  eco_credits_awarded INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Badges table
CREATE TABLE IF NOT EXISTS badges (
  id SERIAL PRIMARY KEY,
  badge_name VARCHAR(255) NOT NULL,
  description TEXT,
  icon_url VARCHAR(255),
  requirement VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Badges table
CREATE TABLE IF NOT EXISTS user_badges (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  badge_id INT NOT NULL REFERENCES badges(id) ON DELETE CASCADE,
  earned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, badge_id)
);