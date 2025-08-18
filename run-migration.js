const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

// 環境変数から接続情報を取得
const supabaseUrl = 'https://mdzpuqtlndaelpopajrt.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1kenB1cXRsbmRhZWxwb3BhanJ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU0OTQ0NjgsImV4cCI6MjA3MTA3MDQ2OH0.gy5SIVU4Iqla6CoEOqTkFP1MfDcQrCY4g9ElR8cp2Is';

const supabase = createClient(supabaseUrl, supabaseKey);

// SQLファイルを読み込み
const sql = fs.readFileSync('./add_missing_columns.sql', 'utf8');

console.log('データベースカラムを追加中...');

// 注意：Supabase JSクライアントでは直接SQLを実行できないため、
// REST APIを使用する必要があります
console.log('\n以下のSQLをSupabaseのSQL Editorで実行してください：\n');
console.log(sql);