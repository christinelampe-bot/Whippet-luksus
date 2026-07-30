-- ============================================================
-- Whippet Luksus — Booking System Setup
-- Run this in Supabase SQL Editor
-- Drop existing table first if re-running: DROP TABLE IF EXISTS bookinger CASCADE;
-- ============================================================

CREATE TABLE IF NOT EXISTS bookinger (
  id                    UUID DEFAULT uuid_generate_v4() PRIMARY KEY,

  -- Booking details
  dato                  DATE NOT NULL,
  ukedag                TEXT NOT NULL,                        -- 'mandag','tirsdag' etc.
  rute                  TEXT NOT NULL,                        -- 'Vindern & Holmenkollen' etc.
  type                  TEXT NOT NULL DEFAULT 'enkeltdag',    -- 'enkeltdag' | 'abonnement' | 'manedlig'
  status                TEXT NOT NULL DEFAULT 'bekreftet',    -- 'bekreftet' | 'avlyst'

  -- Owner info
  navn                  TEXT NOT NULL,
  epost                 TEXT NOT NULL,
  telefon               TEXT,
  melding               TEXT,

  -- Dog info
  hund_navn             TEXT NOT NULL,
  hund_kjonn            TEXT,
  hund_alder            TEXT,
  hund_vekt             NUMERIC(4,1),

  -- Health & consent
  medisiner             TEXT,
  allergier             TEXT,
  siste_vaksine         TEXT,
  loppebehandling       TEXT,
  vet_navn              TEXT,
  vet_telefon           TEXT,
  noedkontakt_navn      TEXT,
  noedkontakt_telefon   TEXT,
  atferd                TEXT,

  -- Samtykker
  samtykke_noedvet      BOOLEAN DEFAULT false,
  samtykke_bilde        BOOLEAN DEFAULT false,
  samtykke_vilkaar      BOOLEAN DEFAULT false,
  samtykke_dato         TIMESTAMPTZ DEFAULT NOW(),

  -- Vipps payment (activated when VIPPS_ENABLED = true in booking.html)
  betaling_status       TEXT DEFAULT 'venter',    -- 'venter' | 'betalt' | 'refundert'
  vipps_ref             TEXT,                     -- Vipps transaction ID

  created_at            TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for fast availability lookups
CREATE INDEX IF NOT EXISTS bookinger_dato_idx   ON bookinger (dato);
CREATE INDEX IF NOT EXISTS bookinger_status_idx ON bookinger (status);
CREATE INDEX IF NOT EXISTS bookinger_epost_idx  ON bookinger (epost);

-- Enable Row Level Security
ALTER TABLE bookinger ENABLE ROW LEVEL SECURITY;

-- Public can insert bookings
CREATE POLICY "anon_insert_bookinger"
  ON bookinger FOR INSERT TO anon
  WITH CHECK (true);

-- Public can read date/count data (for availability calendar)
CREATE POLICY "anon_select_bookinger"
  ON bookinger FOR SELECT TO anon
  USING (true);

-- Authenticated (admin) full access
CREATE POLICY "auth_all_bookinger"
  ON bookinger FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ============================================================
-- Verify setup
-- ============================================================
SELECT 'bookinger table created ✓' AS status;
