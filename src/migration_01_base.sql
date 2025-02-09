-- Enable UUID generation extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id TEXT UNIQUE,
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  password_hash TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Create user_settings table
CREATE TABLE IF NOT EXISTS user_settings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles (id) ON DELETE CASCADE,
  key TEXT NOT NULL,
  value JSONB NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE (user_id, key)
);

-- Create function to initialize user settings
CREATE OR REPLACE FUNCTION initialize_user_settings()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert system scope positions
    INSERT INTO user_settings (user_id, key, value)
    VALUES (
        NEW.id,
        'preferences',
         json_build_object(
           'theme', 'light',
           'language', 'en'
         )
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for new profiles
CREATE TRIGGER create_user_settings_for_new_profile
    AFTER INSERT ON profiles
    FOR EACH ROW
    EXECUTE FUNCTION initialize_user_settings();

alter table profiles add column role text default 'user';
alter table profiles add constraint valid_role check (role in ('user', 'admin', 'superadmin'));

-- Add new columns
alter table profiles 
add column is_suspended boolean default false not null,
add column last_sign_in timestamp with time zone,
add column password_reset_token text,
add column password_reset_expires timestamp with time zone;

-- Add indexes
create index idx_profiles_role on profiles(role);
create index idx_profiles_last_sign_in on profiles(last_sign_in);

