-- schedule_itemsテーブルのtype制約を更新して'custom'を許可
-- （注：実際にはcustomはpreparationとして保存されるため、この変更は不要かもしれませんが、念のため）
-- ALTER TABLE schedule_items DROP CONSTRAINT IF EXISTS schedule_items_type_check;
-- ALTER TABLE schedule_items ADD CONSTRAINT schedule_items_type_check 
--   CHECK (type IN ('break', 'preparation', 'custom'));

-- Note: 上記の変更は実際には不要です。
-- コード側でcustomをpreparationに変換しているため、
-- データベース側の制約はそのままで問題ありません。