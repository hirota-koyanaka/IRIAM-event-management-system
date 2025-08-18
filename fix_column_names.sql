-- projectsテーブルのカラム名を修正
-- nameカラムを削除（titleがあるため）
ALTER TABLE projects DROP COLUMN IF EXISTS name;

-- dateカラムを削除（recording_dateがあるため）  
ALTER TABLE projects DROP COLUMN IF EXISTS date;

-- performersテーブルのカラム名を修正
-- project_idカラムがない場合は追加
ALTER TABLE performers DROP CONSTRAINT IF EXISTS performers_project_id_fkey;
ALTER TABLE performers ADD COLUMN IF NOT EXISTS project_id UUID REFERENCES projects(id) ON DELETE CASCADE;

-- plansテーブルのカラム名を修正
-- project_idカラムがない場合は追加
ALTER TABLE plans DROP CONSTRAINT IF EXISTS plans_project_id_fkey;
ALTER TABLE plans ADD COLUMN IF NOT EXISTS project_id UUID REFERENCES projects(id) ON DELETE CASCADE;