-- projectsテーブルの内容を確認
SELECT id, title, recording_date, total_recording_time, location, created_at 
FROM projects 
ORDER BY created_at DESC;

-- titleがNULLのレコードがあるか確認
SELECT COUNT(*) as null_title_count 
FROM projects 
WHERE title IS NULL;