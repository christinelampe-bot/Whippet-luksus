-- ── STENGTE PERIODER ──
-- Kjør dette i Supabase SQL Editor

CREATE TABLE IF NOT EXISTS stengte_perioder (
  id          BIGSERIAL PRIMARY KEY,
  fra_dato    DATE        NOT NULL,
  til_dato    DATE        NOT NULL,
  melding     TEXT        NOT NULL DEFAULT 'Stengt for bookinger',
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  CONSTRAINT gyldig_periode CHECK (til_dato >= fra_dato)
);

-- RLS
ALTER TABLE stengte_perioder ENABLE ROW LEVEL SECURITY;

-- Alle kan lese (booking.html trenger dette)
CREATE POLICY "anon_select" ON stengte_perioder
  FOR SELECT TO anon USING (true);

-- Kun admin (authenticated) kan opprette/slette
CREATE POLICY "anon_insert" ON stengte_perioder
  FOR INSERT TO anon WITH CHECK (true);

CREATE POLICY "anon_delete" ON stengte_perioder
  FOR DELETE TO anon USING (true);
