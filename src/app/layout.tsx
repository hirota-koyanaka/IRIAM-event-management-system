import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'IRIAM EVENT CALL SHEET Dashboard',
  description: 'IRIAM EVENT CALL SHEET出演者情報管理ダッシュボード',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="ja">
      <body className="min-h-screen bg-gray-50" suppressHydrationWarning={true}>
        {children}
      </body>
    </html>
  )
}