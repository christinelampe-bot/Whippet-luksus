---
name: site-validator
description: >
  Validates the deployed Whippet Luksus website for errors and fixes them automatically.
  Use this skill whenever Christine says things like "sjekk nettsiden", "er det feil på siden",
  "deploy er gjort — kan du sjekke?", "noe galt på siden", "site check", "valider siden", or
  after any deploy/push to GitHub. The skill opens both pages in a browser, checks for console
  errors, broken images, Supabase connection issues, and broken links — then patches the source
  files directly if it finds anything wrong.
---

# Site Validator — Whippet Luksus

Du er ansvarlig for å sikre at Whippet Luksus-nettsiden fungerer korrekt etter deploy.
Du har tilgang til Chrome-nettleseren og til kildefilene i prosjektmappen.

## Prosjektkontekst

- **Sider:** `index.html` (markedsføring) og `booking.html` (bookingsystem)
- **Supabase:** `https://nobmpsyqwalpnlsrtgny.supabase.co` — brukes i booking.html for tilgjengelighet
- **Filer:** Ligger i Christine sin valgte mappe (`Whippet luksus/`)
- **Deploy:** Vercel via GitHub — URL ukjent inntil Christine bekrefter den

## Steg 1 — Finn Vercel-URL

Spør Christine om Vercel-URL hvis du ikke kjenner den. Den ser typisk slik ut:
`https://whippet-luksus.vercel.app` eller `https://whippet-luksus-[hash].vercel.app`

Alternativt: naviger til `https://vercel.com/dashboard` i nettleseren og finn prosjektet
`christinelampe-bot/Whippet-luksus`.

## Steg 2 — Åpne og sjekk index.html

Naviger til den deployede URL-en. For hvert punkt under, noter funn:

**Visuelt:**
- Laster siden uten hvit skjerm eller layout-feil?
- Vises hero-seksjonen med mauve-gradienten?
- Laster galleribilder (eller vises fallback-farger — begge er OK)?
- Vises pris-seksjonens 4 kort korrekt?
- Fungerer navigasjonslenker (Book nå → booking.html)?

**Konsoll:**
- Bruk `read_console_messages` for å hente JavaScript-feil
- Se spesielt etter: Supabase-feil, 404-er, CORS-feil

**Lenker:**
- "Book nå" i nav → booking.html
- "Book nå"-knapper i prisseksjonen → booking.html
- Hero CTA → booking.html

## Steg 3 — Åpne og sjekk booking.html

Naviger til `[URL]/booking.html`. Sjekk:

**Funksjonalitet:**
- Vises ukeskalenderen med 5 dager (Man–Fre)?
- Laster tilgjengelighetsdata fra Supabase? (dagkortene skal vise "X ledige" eller "Fullt")
- Vises de 3 priskortene (Enkeltdag / 5-dagerspakke / Månedspakke)?
- Klikk på en ledig dag → vises bookingskjema?
- Vises samtykkeskjema (accordion) i skjemaet?
- Vises Vipps-seksjonen med "Kommer snart" (når VIPPS_ENABLED = false)?

**Konsoll:**
- Supabase-tilkobling: finner du feil som `Failed to fetch` eller `401 Unauthorized`?
- JavaScript-feil i kalender-logikken?

## Steg 4 — Diagnostiser og fiks

For hvert problem du finner, gjør følgende:

1. **Identifiser rot-årsaken** — er det i HTML, CSS eller JavaScript?
2. **Les den relevante kildefilen** (`index.html` eller `booking.html`)
3. **Fiks direkte** med Edit-verktøyet
4. **Beskriv hva du fikset** i rapporten

Vanlige feil å se etter:
- Supabase anon-key feil eller utdatert
- Brutt JavaScript (syntaksfeil, manglende semikolon, undefined variables)
- CSS som ikke laster (manglende font-lenker, feil URL)
- Hardkodede URLs som peker til feil miljø
- Manglende `onerror`-fallback på bilder
- Kapasitetslogikk som ikke stemmer (maks er 8 per dag)

## Steg 5 — Rapport

Avslutt alltid med en strukturert rapport:

```
## Valideringsrapport — [dato]

**index.html:** ✅ OK / ⚠️ Feil funnet
**booking.html:** ✅ OK / ⚠️ Feil funnet
**Supabase-tilkobling:** ✅ OK / ❌ Feil

### Feil funnet og rettet:
- [Beskrivelse av feil] → [Hva som ble fikset]

### Feil funnet men ikke rettet (krever manuell handling):
- [Beskrivelse + anbefalt handling]

### Neste steg:
- [Eventuelle anbefalinger]
```

Hvis du rettet noe: påminn Christine om å pushe via **GitHub Desktop** så Vercel deployer fixen.

## Tips

- Supabase-feil i konsollen betyr ofte at RLS-policiene ikke er satt riktig, eller at anon-nøkkelen er galt
- Hvis booking-kalenderen er tom, sjekk at `bookinger`-tabellen eksisterer i Supabase
- Vipps-knappen skal alltid vise "Kommer snart" til `VIPPS_ENABLED = true` er satt
- Galleribildene kan feile (Wikimedia egress er ustabilt) — onerror-fallbacks skal håndtere dette stilfullt
