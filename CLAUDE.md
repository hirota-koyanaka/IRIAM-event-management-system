# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 重要な指示

**すべてのやり取りは日本語で回答してください。** コードのコメントも日本語で記述し、エラーメッセージや説明も日本語で提供してください。

## Project Overview

BEAUTY ROAD Dashboard - A Next.js 15 application for managing TV show performer information, schedules, and project planning. The system serves two distinct user types: administrators (full CRUD operations) and performers (read-only access to their schedules).

## Essential Commands

```bash
# Development
npm run dev          # Start development server on localhost:3000

# Build & Production
npm run build        # Build for production
npm start            # Start production server

# Code Quality
npm run lint         # Run ESLint
```

## Architecture

### Tech Stack
- **Framework**: Next.js 15.3.3 with App Router
- **Language**: TypeScript 5.8.3 (strict mode)
- **Styling**: Tailwind CSS 4.1.8
- **Database**: Supabase (PostgreSQL with RLS)
- **Auth**: Cookie-based admin authentication

### Directory Structure
```
src/
├── app/              # Next.js App Router pages
│   ├── admin/        # Admin-only pages (protected)
│   ├── project/      # Public project viewer pages
│   └── page.tsx      # Login page
├── components/       # React components
│   ├── ComprehensiveSchedule.tsx  # Main schedule display
│   ├── ScheduleEditor.tsx         # Interactive editing
│   └── TimeInput.tsx               # Time input component
├── lib/              # Core logic and utilities
│   ├── auth.ts       # Cookie-based authentication
│   ├── data.ts       # localStorage data management (legacy)
│   ├── database.ts   # All Supabase CRUD operations
│   ├── supabase.ts   # Supabase client initialization
│   └── utils.ts      # Time calculation utilities
└── types/
    └── index.ts      # Central type definitions
```

### Key Architectural Patterns

1. **Authentication Flow**:
   - Single admin password in `ADMIN_PASSWORD` environment variable
   - Cookie-based session (`isAuthenticated` cookie, 24-hour expiry)
   - Server-side auth checks in protected routes

2. **Data Operations**:
   - All database operations centralized in `lib/database.ts`
   - Direct client-side Supabase SDK calls (no API routes)
   - Transform functions for snake_case ↔ camelCase conversion
   - Dual data systems: Supabase (production) and localStorage (legacy/fallback)

3. **Type Safety**:
   - Central types in `src/types/index.ts`
   - Database types from Supabase schema
   - Path alias `@/*` maps to `src/*`
   - Strict TypeScript mode enabled

4. **UI Patterns**:
   - Japanese language throughout
   - Mobile-responsive with Tailwind utilities
   - Time formats support Japanese notation ("30分", "1時間30分")
   - Confirmed/unconfirmed state management for schedules

### Database Schema

**Core Tables & Relationships**:
```
projects
├── performers (project_id FK)
├── plans (project_id FK)
├── schedule_items (project_id FK)
└── plan_performers (plan_id + performer_id junction)

proposals (standalone proposal system)
```

**Schema Characteristics**:
- UUID primary keys on all tables
- Automatic `updated_at` via database triggers
- Row Level Security enabled with open policies
- Progressive migrations in `/supabase/migrations/`

### Environment Variables

Required in `.env.local`:
```
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
ADMIN_PASSWORD=your-admin-password
```

## Development Workflow

### Route Structure
- `/` - Login page
- `/project/[id]` - Public project view
- `/project/[id]/performer/[performerId]` - Individual performer view
- `/admin/*` - Protected admin routes
- `/admin/demo` - Demo system with sample data
- `/admin/proposal/*` - Proposal management

### Data Management
- **Production**: Direct Supabase operations via `lib/database.ts`
- **Demo Mode**: Session storage with sample data at `/admin/demo`
- **Legacy Support**: localStorage fallback in `lib/data.ts`

### Key Business Logic
- **Schedule Management**: Complex timeline calculations with breaks and preparation time
- **Project Operations**: Creation, editing, duplication with nested entity management
- **Performer Assignment**: Many-to-many relationships through `plan_performers`
- **Time Calculations**: Utilities in `lib/utils.ts` for duration parsing and formatting

## Important Notes

- No test suite currently implemented
- All database operations are client-side (no server-side API protection)
- Open RLS policies rely on application-level security
- Demo system provides comprehensive testing environment
- Japanese content and UI throughout the application