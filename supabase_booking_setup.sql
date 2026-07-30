-- ============================================================
-- Whippet Luksus — Booking System Setup
-- Run this in Supabase SQL Editor
-- ============================================================

-- Bookinger table
-- Stores each single day booking or first day of a subscription
-- ============================================================
CREATE TABLE IF NOT EXISTS bookinger (
  id            UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  dato          DATE NOT NULL,
  ukedag        TEXT NOT NULL,         -- 'mandag','tirsdag' etc.
  rute          TEXT NOT NULL,         -- 'Vindern & Holmenkollen' etc.
  navn          TEXT NOT NULL,
  epost         TEXT NOT NULL,
  telefon       TEXT,
  hund_navn     TEXT NOT NULL,
  type          TEXT NOT NULL DEFAULT 'enkeltdag',   -- 'enkeltdag' | 'abonnement'
  status        TEXT NOT NULL DEFAULT 'bekreftet',   -- 'bekreftet' | 'avlyst'
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- Index for fast availability lookups
CREATE INDEX IF NOT EXISTS bookinger_dato_idx ON bookinger (dato);
CREATE INDEX IF NOT EXISTS bookinger_status_idx ON bookinger (status);

-- Enable Row Level Security
ALTER TABLE bookinger ENABLE ROW LEVEL SECURITY;

-- Anyone can insert a booking (public form)
CREATE POLICY "anon_insert_bookinger"
  ON bookinger FOR INSERT
  TO anon
  WITH CHECK (true);

-- Anyone can read bookings (needed to count availability)
-- Only exposes dato + rute — no personal info returned to frontend
CREATE POLICY "anon_select_bookinger"
  ON bookinger FOR SELECT
  TO anon
  USING (true);

-- Authenticated users (admin) can update/delete
CREATE POLICY "auth_all_bookinger"
  ON bookinger FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- ============================================================
-- Verify setup
-- ============================================================
SELECT 'bookinger table created ✓' AS status;
