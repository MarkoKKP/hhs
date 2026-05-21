# House Hill Star — Claude Code project context

## What this is

Marketing site for **House Hill Star**, a private boutique vacation villa in Kumbor (Boka Kotorska, Montenegro). Site's only job is to push qualified visitors to the Booking.com listing.

- Booking listing: `https://www.booking.com/hotel/me/house-hill-star-kumbor.sr.html`
- Domain: `househillstar.com`
- Audience: couples, global (regional + EU + RU)

## Tech stack

- **Astro 4** static site with built-in i18n
- **Three languages**: SR (default, latinica), EN, RU
- **No** booking forms, calendars, or payment — all reservations go to Booking.com
- **No** hard-coded prices or ratings
- **No** Booking.com Partner widget — owner doesn't have Partner access, so reviews are static curated cards (replace text in `src/i18n/ui.ts` when real reviews are collected)

## Deployment — IMPORTANT

**Owner does not run Node.js or npm locally** (Windows machine, no local dev environment). Deploy is **server-pull from cPanel**:

1. Edit files in this repo (locally or via Claude)
2. Commit + push to `main` branch on GitHub
3. GitHub Actions runs `.github/workflows/ci.yml` — validates the build (no deploy)
4. Owner SSHes into cPanel server and runs `~/hhs/bin/deploy.sh`
5. Script pulls latest, builds Astro, rsyncs `dist/` → `public_html/`, purges Cloudflare

**Implications when editing:**
- Never assume the owner can test locally. Verify Astro syntax by careful reading + relying on the CI build.
- Don't introduce `package-lock.json` — server uses `npm install`, not `npm ci`.
- Don't add tooling that requires local Node (Husky, prettier-on-save, etc.).
- All previews happen on the live site post-deploy.
- The CI workflow only validates the build — it does NOT deploy. Deploy is manual on the server.

See `README.md` for the full owner-facing setup guide (cPanel Node.js Selector, clone repo, run deploy.sh).

## Repo layout

```
hhs/
├── .github/workflows/ci.yml      # CI build validation (no deploy)
├── bin/deploy.sh                 # server-side deploy script (run on cPanel via SSH)
├── assets/photos/                # source photos by subject (interior/, terrace/, ...)
├── brand-book.md                 # canonical brand reference — read before any design work
├── design-preview.html           # original 3 brand directions (Hillside Twilight chosen)
├── logo-concepts.html            # 3 logo directions (Concept 01 — The Star — chosen, dark variant)
├── src/
│   ├── components/               # SiteHeader, SiteFooter
│   ├── i18n/ui.ts                # all UI strings + booking URLs per language
│   ├── layouts/BaseLayout.astro
│   ├── pages/                    # index.astro = SR homepage; /en/, /ru/ to follow
│   └── styles/tokens.css         # design tokens (colors, type scale, spacing)
├── public/                       # static — favicon, og images
├── astro.config.mjs
├── package.json
├── README.md                     # owner-facing setup guide
└── CLAUDE.md                     # this file
```

## Brand direction (locked in)

**Hillside Twilight** — cinematic boutique. Indigo + gold palette, Playfair Display + Manrope typography, editorial voice. See [brand-book.md](brand-book.md) for full spec.

**Logo**: Concept 01 — The Star (dark variant). Wordmark `HOUSE ★ HILL ★ STAR` with gold 4-point star separators. Favicon: gold star on indigo blue.

**Voice**: third person, editorial-magazine. Never first-person plural ("we"), never exclamation marks, never generic luxury adjectives. Show with sensory specifics; don't tell. See `brand-book.md` §2 for examples.

**Anti-patterns specific to this project** (don't even ask, just don't):
- 3-column or 4-column icon-card feature grids (box method)
- "Stay 3 nights save 10%" type promotions
- Generic stock photography
- Family-friendly language (this is for couples)
- Custom booking calendars (Booking.com owns that)
- Multiple CTAs per section
- WiFi/AC/parking icons (list them as words instead)
- Booking.com Partner embed widget (no Partner access)

## Conventions

### Adding a page

1. Create `src/pages/<route>.astro` for SR (default locale, no prefix)
2. Create `src/pages/en/<route>.astro` and `src/pages/ru/<route>.astro` for translations
3. Add all UI strings to `src/i18n/ui.ts` under SR first; add `// TODO: phase 2 translation` markers for EN/RU
4. Use `useTranslations(lang)` hook for all visible strings — no hardcoded text in templates
5. Use `BaseLayout`, `SiteHeader`, `SiteFooter` components — don't recreate

### Adding photos

Drop into `assets/photos/<subject>/` with the naming convention in `assets/photos/README.md`. At build time we'll generate optimized versions; reference them from templates via the `import` syntax.

Until real photos arrive, sections show typographic placeholders (filename hints like `terrace-sunset-01.jpg`).

### Adding components

- Components live in `src/components/`
- One component = one `.astro` file, scoped `<style>` block included
- Use design tokens from `tokens.css` — never hardcode hex values or font names
- Component CSS classes use BEM-ish naming (`block__element--modifier`) but kept short

### Booking.com CTAs

Always import `bookingUrl` from `src/i18n/ui.ts` and use the language-matched URL. Open in new tab (`target="_blank" rel="noopener"`).

### Reviews

Static curated cards (3 testimonials) on the homepage. Edit content in `src/i18n/ui.ts` under `review.1.quote`, `review.2.quote`, `review.3.quote` keys. **Do not** wire in Booking.com widgets — owner doesn't have Partner access.

## Current state (MVP scope)

- ✅ Brand book (Hillside Twilight)
- ✅ Logo concept selected (Concept 01 — The Star, dark variant)
- ✅ Favicon (indigo + gold star)
- ✅ Astro scaffold + trilingual i18n setup
- ✅ Homepage (SR) — hero, intro, signature feature, location teaser, gallery teaser, reviews (3 static cards), closing CTA
- ✅ GitHub Actions CI workflow (build validation)
- ✅ Server-side deploy script (`bin/deploy.sh`) — git pull + build + rsync + CF purge
- ✅ README with owner setup guide
- ⏳ Photo color-grading pass (apply tokens from brand-book.md §7 once photos arrive)
- ⏳ EN and RU translations
- ⏳ Galerija, Kumbor, O nama pages
- ⏳ FAQ section
- ⏳ Owner adds real photos and real review quotes
- ⏳ "O nama" persona (will be decided after seeing 2 text drafts)

## Hosting facts

- cPanel hosting (WHM-managed), with Cloudflare in front
- Static files served by Apache/LiteSpeed from `/public_html/`
- SSL termination at Cloudflare
- DNS managed at Cloudflare
- No Node.js required on the server — site is fully static
