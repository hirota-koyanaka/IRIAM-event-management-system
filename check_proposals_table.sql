-- proposalsテーブルの現在のカラムを確認
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'proposals'
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 古いカラムを削除（もし存在すれば）
ALTER TABLE proposals 
DROP COLUMN IF EXISTS name,
DROP COLUMN IF EXISTS script_url,
DROP COLUMN IF EXISTS reference_materials,
DROP COLUMN IF EXISTS location;

-- titleカラムがNOT NULLでない場合は設定
ALTER TABLE proposals 
ALTER COLUMN title DROP NOT NULL;