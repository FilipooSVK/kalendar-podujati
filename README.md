# Prehľad podujatí — cloudová verzia v2

## Čo obsahuje
- `index.html` — hotová webová aplikácia, mesačné záložky november 2026 – máj 2027, pridávanie, úpravy, mazanie, vyhľadávanie, CSV, kopírovanie a automatická synchronizácia každých 30 sekúnd.
- `schema.sql` — PostgreSQL tabuľka `public.events`, validácie, index, trigger a RLS politiky pre anonymné čítanie, pridávanie, úpravy a mazanie.
- `config.js` — nastavenia pripojenia k Supabase.

## Spustenie
1. Na https://supabase.com/dashboard vytvor NOVÝ Supabase projekt.
2. Otvor SQL Editor, vlož obsah `schema.sql` a klikni Run.
3. V Supabase v časti Project Settings → API (alebo Connect) skopíruj **Project URL** a **publishable key** (`sb_publishable_...`) alebo legacy **anon key**.
4. Otvor `config.js` a vymeň `YOUR-PROJECT` a `YOUR-PUBLISHABLE-KEY` za svoje hodnoty. **Nikdy nepouži secret/service_role key!**
5. Nahraj `index.html` a `config.js` do rovnakého priečinka na Netlify alebo Vercel (statický web). HTTPS poskytne hosting. Prípadne otestuj lokálne cez `python3 -m http.server 8000` a otvor http://localhost:8000.
6. Pridaj testovacie podujatie, obnov stránku a otvor aplikáciu aj v inom prehliadači. Podujatie sa musí zobraziť obom.

## Bezpečnosť
**V tejto verzii môže ktokoľvek s odkazom nielen čítať, ale aj meniť a vymazať všetky údaje.** Anonymné RLS politiky to zámerne povoľujú. Nie je to vhodné pre citlivé údaje ani pre verejný web bez ochrany pred spamom. Pred širším zverejnením zváž schvaľovanie zmien, rate limiting cez serverovú vrstvu a zálohovanie. Nikdy neukladaj tajné API kľúče do frontendových súborov.

## Poznámky
- Bez Supabase konfigurácie sa dá zobraziť rozhranie, ale databázové operácie nefungujú.
- Projekt neobsahuje žiadne predvyplnené podujatia.
- Súbory sú statické; nevyžadujú npm ani build.
- Pri testovaní bolo overené vytvorenie súborov a syntax JavaScriptu, nie spojenie s tvojím Supabase projektom.
