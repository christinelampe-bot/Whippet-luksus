# Whippet Luksus — Prosjektminne

> **For Claude:** Les denne filen ved oppstart av hver økt. Oppdater den på slutten av hver økt med nye beslutninger, endringer og status. Hold den presis og faktaorientert.

---

## Hva er Whippet Luksus?

Oslos første mobile hundedagplass for whippets og myndefamilien. Inspirert av [Golden Buggy AZ](https://www.goldenbuggyaz.com/). Klimastyrt luksus-buggy henter hunden hjemme, tar dem på naturopplevelser og bringer dem hjem.

**Eier:** Christine Lampe · christine.lampe@visma.com · lampe.christine@gmail.com  
**Status:** Under utvikling — ikke åpnet enda

---

## Aksepterte raser

- **Primær:** Whippet
- **Også akseptert:** hele myndefamilien — greyhound, italiensk mynde, galgo español, saluki, borzoi, sloughi og lignende
- Ingen blandede grupper med andre raser

---

## Ruter & kapasitet

**Opphenting:** Hele Oslo og omegn alle dager — kunden trenger IKKE bo i det aktuelle området.
**Naturmål per dag** (der buggyen tar hundene):

| Dag | Naturmål | Maks hunder |
|-----|----------|-------------|
| Mandag | Vindern & Holmenkollen (Nordmarka, skog) | 8 |
| Tirsdag | Nordstrand (Oslofjorden, Ekeberg) | 8 |
| Onsdag | Høvik & Jar (Lysakerelveni, elvesti) | 8 |
| Torsdag | Oslo Sentrum (Frognerparken, Aker Brygge) | 8 |
| Fredag | Lillestrøm & Rælingen (åpne jorder, sprint) | 8 |

---

## Priser

| Produkt | Pris | Detaljer |
|---------|------|----------|
| Enkeltdag | kr 550 | Per dag, ingen binding |
| **Månedspakke** | **kr 1 990/mnd** | Opptil 5 dager/mnd, spredt eller sammenhengende, 28% spart |
| Deltidspakke | kr 1 990/uke | 3 faste dager per uke — garantert fast plass |
| Heltidspakke | kr 2 990/uke | Alle 5 dager — maks inntekt per hund |

**Månedspakke-vilkår:** 1 måneds oppsigelse, gjeldende fra utgangen av en kalendermåned.  
**Tillegg:** +kr 250/dag for ekstra hund (samme husstand) · −kr 75/dag ved busstopp-møte

---

## Teknisk stack

| Komponent | Løsning |
|-----------|---------|
| Frontend | Statisk HTML/CSS/JS (to filer) |
| Database | Supabase |
| Hosting | Vercel |
| Kildekode | GitHub: `christinelampe-bot/Whippet-luksus` |
| Betaling | Vipps (placeholder, ikke aktivert enda) |
| Deploy-workflow | GitHub Desktop → Push origin → Vercel auto-deploy |

> **Viktig:** Sandboxen kan ikke pushe til GitHub (egress blokkert). Christine pusher alltid selv via GitHub Desktop.

---

## Supabase

- **URL:** `https://nobmpsyqwalpnlsrtgny.supabase.co`
- **Anon key:** `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5vYm1wc3lxd2FscG5sc3J0Z255Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc5ODUwMjQsImV4cCI6MjA5MzU2MTAyNH0.qNuTctR_kDhEItvKR53craND1l0BybSRei5olPxXCz8`
- **Tabell:** `bookinger` — booking + samtykkeskjema + Vipps-status
- **RLS:** anon INSERT og SELECT aktivert, authenticated har full tilgang
- ⚠️ Service role key skal ALDRI i frontend-kode

---

## Filer i prosjektet

```
Whippet luksus/
├── index.html                       — Markedsføringssiden (landing page)
├── booking.html                     — Bookingsystem med kalender + samtykkeskjema + Vipps
├── admin.html                       — Admin-side: steng/åpne bookingperioder (passord: WhippetLuksus2026)
├── survey.html                      — Markedsvalideringssurvey (10 spørsmål til potensielle kunder)
├── supabase_booking_setup.sql       — SQL for bookinger-tabell (kjørt)
├── supabase_stengte_perioder.sql    — SQL for stengte_perioder-tabell (må kjøres i Supabase)
├── manifest.json                    — PWA-manifest for hjemskjermikon
├── apple-touch-icon.png             — iOS-ikon (180x180)
├── icon-192.png / icon-512.png      — PWA-ikoner
├── favicon-32x32.png                — Nettleserfavicon
├── vercel.json                      — Vercel routing
├── CLAUDE.md                        — Denne filen
```

---

## Design-beslutninger

- **Primærfarge:** `#E0B0FF` (bright electric lavender/mauve)
- **Tonalitet:** Luksus, Instagram-vennlig, paw-motiv gjennomgående
- **Fonter:** Cormorant Garamond (headings, serif) + Jost (body, sans)
- **Bakgrunnsgradering hero:** `linear-gradient(145deg, #1A0F2E → #2D1B4E → #7B3DB8 → #B060E8)`
- **CSS tokens:** Definert som `--mauve`, `--mauve-deep`, `--mauve-dark` osv. i `:root`
- **Galleri:** Wikimedia Commons-bilder (CC BY-SA) med onerror-fallbacks — erstattes med egne TikTok-bilder når konto er aktiv

---

## Bookingsystem (booking.html)

- **Ukeskalender:** Viser Man–Fre med live tilgjengelighet fra Supabase
- **Prisvalg:** 3 kort (Enkeltdag / 5-dagerspakke / Månedspakke)
- **Samtykkeskjema** (Rover-inspirert, collapsible accordion):
  - Hundens info, helse, medisiner, vaksinasjoner
  - Veterinær + nødkontakt
  - Atferd og temperament
  - 3 samtykke-checkboxer: nødvet (påkrevd), bilde/sosiale medier, vilkår (påkrevd)
- **Vipps-panel** vises etter vellykket booking
  - Aktiveres ved å sette `VIPPS_ENABLED = true` og `VIPPS_MERCHANT_PHONE` i booking.html
  - Viser "Kommer snart" til det er aktivert

---

## Åpne oppgaver / neste steg

- [ ] **Vipps aktivering** — sett `VIPPS_ENABLED = true` + legg inn Vipps-businessnummer
- [ ] **TikTok-konto** — når aktiv: erstatt galleribilder i index.html med egne bilder
- [ ] **Vercel-URL** — bekrefte at siden er live etter deploy
- [ ] **Vilkår & betingelser** — referert til i samtykkeskjemaet, bør lages som egen side
- [ ] **Fakturering** — oppsett for forskuddsvis månedlig fakturering
- [ ] **Survey-svar** — samle inn svar fra survey.html og analysere (koble til Supabase eller bruk Google Forms)
- [ ] **Grill-me fortsettelse** — Q4 ("Har du snakket med faktiske whippet-eiere?") venter

---

## Kjente tekniske begrensninger

- GitHub/Vercel egress er blokkert fra sandbox — all pushing skjer via GitHub Desktop
- Wikimedia Commons-bilder kan ikke verifiseres fra sandbox — bruker beregnede MD5-URLs med fallbacks
- Supabase service_role key må aldri eksponeres i frontend

---

## Sesjonslogg

| Dato | Hva ble gjort |
|------|--------------|
| 2026-07-30 | Opprettet hele prosjektet: index.html (landing page), booking.html (bookingsystem med kalender, samtykkeskjema, Vipps-placeholder), Supabase-tabell (bookinger), prissetting, månedspakke med oppsigelsesvilkår, kapasitet oppdatert til 8/dag, myndefamilien lagt til, galleri oppdatert med sosiale/natur-bilder, oppstartssjekkliste.docx, site-validator skill, CLAUDE.md, survey.html (10-spørsmåls markedsvalideringssurvey) |
