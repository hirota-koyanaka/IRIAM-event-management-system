-- location_map_url カラムを projects テーブルに追加
ALTER TABLE projects 
ADD COLUMN IF NOT EXISTS location_map_url TEXT;

-- 他の不足している可能性のあるカラムも追加
ALTER TABLE projects 
ADD COLUMN IF NOT EXISTS title TEXT;

ALTER TABLE projects 
ADD COLUMN IF NOT EXISTS recording_date TEXT;

ALTER TABLE projects 
ADD COLUMN IF NOT EXISTS total_recording_time TEXT;

-- performers テーブルの不足カラム
ALTER TABLE performers 
ADD COLUMN IF NOT EXISTS start_time TEXT;

ALTER TABLE performers 
ADD COLUMN IF NOT EXISTS end_time TEXT;

ALTER TABLE performers 
ADD COLUMN IF NOT EXISTS available_start_time TEXT;

ALTER TABLE performers 
ADD COLUMN IF NOT EXISTS available_end_time TEXT;

ALTER TABLE performers 
ADD COLUMN IF NOT EXISTS is_time_confirmed BOOLEAN DEFAULT false;

ALTER TABLE performers 
ADD COLUMN IF NOT EXISTS role TEXT;

ALTER TABLE performers 
ADD COLUMN IF NOT EXISTS program_items TEXT;

-- plans テーブルの不足カラム
ALTER TABLE plans 
ADD COLUMN IF NOT EXISTS title TEXT;

ALTER TABLE plans 
ADD COLUMN IF NOT EXISTS scheduled_time TEXT;

ALTER TABLE plans 
ADD COLUMN IF NOT EXISTS script_url TEXT;

ALTER TABLE plans 
ADD COLUMN IF NOT EXISTS has_script BOOLEAN DEFAULT false;

ALTER TABLE plans 
ADD COLUMN IF NOT EXISTS notes TEXT;

ALTER TABLE plans 
ADD COLUMN IF NOT EXISTS reference_video_url TEXT;

ALTER TABLE plans 
ADD COLUMN IF NOT EXISTS is_confirmed BOOLEAN DEFAULT false;

-- plan_performers テーブルの不足カラム
ALTER TABLE plan_performers 
ADD COLUMN IF NOT EXISTS role TEXT;

ALTER TABLE plan_performers 
ADD COLUMN IF NOT EXISTS custom_role TEXT;