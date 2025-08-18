-- プロジェクトテーブル
CREATE TABLE IF NOT EXISTS projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  date TEXT,
  location TEXT,
  address TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- パフォーマーテーブル
CREATE TABLE IF NOT EXISTS performers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
  arrival_time TEXT,
  prep_duration TEXT,
  belongings TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- プランテーブル
CREATE TABLE IF NOT EXISTS plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_index INTEGER NOT NULL DEFAULT 0,
  project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
  start_time TEXT,
  duration TEXT,
  content TEXT,
  location TEXT,
  confirmed BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- プラン・パフォーマー関連テーブル（多対多）
CREATE TABLE IF NOT EXISTS plan_performers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID REFERENCES plans(id) ON DELETE CASCADE,
  performer_id UUID REFERENCES performers(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  UNIQUE(plan_id, performer_id)
);

-- スケジュールアイテムテーブル（休憩・準備時間）
CREATE TABLE IF NOT EXISTS schedule_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK (type IN ('break', 'preparation')),
  start_time TEXT,
  duration TEXT,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- 提案テーブル
CREATE TABLE IF NOT EXISTS proposals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  youtube_url TEXT,
  script_url TEXT,
  references TEXT,
  location TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- updated_at を自動更新するための関数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = TIMEZONE('utc', NOW());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 各テーブルにトリガーを設定
CREATE TRIGGER update_projects_updated_at BEFORE UPDATE ON projects
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_performers_updated_at BEFORE UPDATE ON performers
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_plans_updated_at BEFORE UPDATE ON plans
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_schedule_items_updated_at BEFORE UPDATE ON schedule_items
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_proposals_updated_at BEFORE UPDATE ON proposals
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security (RLS) を有効化
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE performers ENABLE ROW LEVEL SECURITY;
ALTER TABLE plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE plan_performers ENABLE ROW LEVEL SECURITY;
ALTER TABLE schedule_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE proposals ENABLE ROW LEVEL SECURITY;

-- 公開アクセスポリシー（開発用 - 本番環境では適切な認証を追加してください）
CREATE POLICY "Allow public access" ON projects FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow public access" ON performers FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow public access" ON plans FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow public access" ON plan_performers FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow public access" ON schedule_items FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow public access" ON proposals FOR ALL USING (true) WITH CHECK (true);

-- インデックスの作成（パフォーマンス向上）
CREATE INDEX IF NOT EXISTS idx_performers_project_id ON performers(project_id);
CREATE INDEX IF NOT EXISTS idx_plans_project_id ON plans(project_id);
CREATE INDEX IF NOT EXISTS idx_plan_performers_plan_id ON plan_performers(plan_id);
CREATE INDEX IF NOT EXISTS idx_plan_performers_performer_id ON plan_performers(performer_id);
CREATE INDEX IF NOT EXISTS idx_schedule_items_project_id ON schedule_items(project_id);