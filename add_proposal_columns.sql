-- proposalsテーブルに不足しているカラムを追加
ALTER TABLE proposals 
ADD COLUMN IF NOT EXISTS title TEXT,
ADD COLUMN IF NOT EXISTS title_note TEXT,
ADD COLUMN IF NOT EXISTS recording_date_text TEXT,
ADD COLUMN IF NOT EXISTS recording_time_text TEXT,
ADD COLUMN IF NOT EXISTS location_text TEXT,
ADD COLUMN IF NOT EXISTS overview TEXT,
ADD COLUMN IF NOT EXISTS youtube_embed_id TEXT,
ADD COLUMN IF NOT EXISTS video_description TEXT,
ADD COLUMN IF NOT EXISTS appearance_fee_type TEXT,
ADD COLUMN IF NOT EXISTS appearance_fee_text TEXT,
ADD COLUMN IF NOT EXISTS transportation_type TEXT,
ADD COLUMN IF NOT EXISTS transportation_text TEXT,
ADD COLUMN IF NOT EXISTS expense_note TEXT,
ADD COLUMN IF NOT EXISTS slug TEXT,
ADD COLUMN IF NOT EXISTS is_published BOOLEAN DEFAULT false,
ADD COLUMN IF NOT EXISTS expires_at TIMESTAMP WITH TIME ZONE,
ADD COLUMN IF NOT EXISTS viewed_count INTEGER DEFAULT 0;

-- slugカラムにユニーク制約を追加（重複を防ぐため）
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'proposals_slug_key'
    ) THEN
        ALTER TABLE proposals 
        ADD CONSTRAINT proposals_slug_key UNIQUE (slug);
    END IF;
END $$;