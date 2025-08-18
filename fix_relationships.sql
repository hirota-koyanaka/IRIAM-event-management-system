-- まず、既存の外部キー制約を確認
SELECT 
    tc.constraint_name, 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name 
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' 
  AND tc.table_schema='public'
  AND (tc.table_name='performers' OR tc.table_name='plans');

-- performersテーブルにproject_idカラムが存在することを確認
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'performers' 
  AND table_schema = 'public'
  AND column_name = 'project_id';

-- plansテーブルにproject_idカラムが存在することを確認  
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'plans' 
  AND table_schema = 'public'
  AND column_name = 'project_id';

-- 外部キー制約が存在しない場合は追加
DO $$
BEGIN
    -- performersテーブルの外部キー
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_type = 'FOREIGN KEY' 
        AND table_name = 'performers' 
        AND constraint_name = 'performers_project_id_fkey'
    ) THEN
        ALTER TABLE performers 
        ADD CONSTRAINT performers_project_id_fkey 
        FOREIGN KEY (project_id) 
        REFERENCES projects(id) 
        ON DELETE CASCADE;
    END IF;

    -- plansテーブルの外部キー
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_type = 'FOREIGN KEY' 
        AND table_name = 'plans' 
        AND constraint_name = 'plans_project_id_fkey'
    ) THEN
        ALTER TABLE plans 
        ADD CONSTRAINT plans_project_id_fkey 
        FOREIGN KEY (project_id) 
        REFERENCES projects(id) 
        ON DELETE CASCADE;
    END IF;
END $$;