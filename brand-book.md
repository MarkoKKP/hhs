# House Hill Star — Brand Book

**Direction**: Hillside Twilight · Cinematic Boutique
**Version**: 1.0 · MVP foundation
**Last updated**: 2026-05-21

---

## 1. Identity

### Brand purpose
House Hill Star is a private hillside villa for two, perched above the Bay of Kotor in Kumbor, Montenegro. The brand exists to give one couple at a time complete possession of a quiet view, a private garden, and an unhurried Mediterranean evening.

### Brand promise
*One house. One couple. One view that stays with you.*

### Personality adjectives
**Discreet · Cinematic · Considered · Warm · Unhurried · Resident-quiet**

Not: corporate, hotel-generic, beach-party, family-oriented, budget, loud.

### Positioning statement
> For travellers who treat their holiday as a small ceremony — couples who choose where they sleep with the same care as where they eat — House Hill Star offers an entire private villa above Portonovi, never shared, never compromised. Unlike a hotel room or an apartment block, every square metre of the house — garden, terrace, view — belongs to a single couple for the length of their stay.

### Audience
- **Primary**: Couples (30–55), design-aware, mid-to-upper income, seeking privacy and atmosphere over amenities checklists. Regional (SRB/MNE/HR/BiH), EU (DE/IT/AT), Russian-speaking markets.
- **Secondary**: Honeymooners, anniversary travellers, off-season escape seekers.

---

## 2. Voice & Tone

### Voice principles

1. **Editorial, not promotional** — write like a travel magazine feature, not a hotel listing. Describe scenes; don't recite amenities.
2. **Third person, deliberate distance** — the house is the subject, not "we" or "you". This distance is what makes it feel curated.
3. **Sensory specifics over abstract praise** — "the smell of pine after rain" beats "beautiful surroundings". One concrete detail outweighs three adjectives.
4. **Restraint** — short sentences. Strong nouns. No exclamation marks. No emoji. No "amazing", "stunning", "perfect".
5. **Trust the reader** — never explain what the photo already shows.

### Tone calibration

| Context | Register |
|---------|----------|
| Hero headlines | Poetic, fragmentary, never a full pitch |
| Section intros | Editorial, atmospheric, scene-setting |
| Amenity lists | Quiet, factual, single nouns where possible |
| Booking CTA | Direct, low-friction, no hard sell |
| FAQ / policies | Plain, precise, helpful |
| Footer / legal | Neutral, professional |

### Voice — do / don't

| Do | Don't |
|----|-------|
| *„Kuća na brdu, otvorena samo prema zalivu."* | *„Najlepša vila u Boki Kotorskoj!"* |
| *„Terasa zapadno orijentisana. Zalasci iste svake večeri — i nikad isti."* | *„Uživajte u nezaboravnim zalascima sunca sa naše terase!"* |
| *„Smeštaj za jedan par."* | *„Idealno za parove i mlade ljude koji žele luksuz!"* |
| *„Od balkona do mora — pet minuta."* | *„Vrhunska lokacija blizu plaže — sve na dohvat ruke!"* |
| *„Privatan ulaz. Privatan vrt. Privatan parking."* | *„Sve što vam je potrebno za savršen odmor!"* |

### Vocabulary anchors

**Use freely**: brdo, zaliv, terasa, sumrak, tišina, privatno, sopstveno, večernji, more, kamen, maslina, vrt, vino, hlad, jutarnji.

**Avoid**: luksuzno (overused — show it, don't say it), nezaboravno, savršeno, idealno, najbolje, fantastično, neverovatno, paradise, gem, hidden treasure.

---

## 3. Color System

### Tokens

| Token | Value | Role |
|-------|-------|------|
| `--color-primary` | `#0F1226` | Midnight Indigo — primary brand, dark surfaces, hero backgrounds |
| `--color-primary-soft` | `#2D3458` | Twilight Indigo — secondary surfaces, card backgrounds on dark mode |
| `--color-accent` | `#C8A96B` | Brushed Gold — CTAs, signature accents, ornament, decorative rules |
| `--color-accent-deep` | `#9C8048` | Burnished Gold — hover state, pressed state |
| `--color-bg` | `#F4F0E8` | Warm Ivory — light backgrounds, page surface |
| `--color-surface` | `#FFFFFF` | Pure White — cards on light bg, dialog panels |
| `--color-text` | `#0F1226` | Body text on light surfaces |
| `--color-text-on-dark` | `#F4F0E8` | Body text on dark surfaces |
| `--color-text-muted` | `#6B6878` | Captions, meta text on light |
| `--color-text-muted-dark` | `#A8A3B8` | Captions on dark |
| `--color-border` | `#E5DFD0` | Hairlines on light |
| `--color-border-dark` | `rgba(200,169,107,0.25)` | Hairlines on dark — gold @ 25% |

### Usage rules

- **Dark mode is the brand default for hero and signature sections.** Light mode is for legibility-heavy sections (FAQ, location, gallery captions).
- **Gold is sacred** — never use it for body text or generic decoration. Reserve it for: primary CTAs, rule lines, signature ornament, key numerals, italicised words inside display headings.
- **No more than two gold accents per visible viewport.** Gold loses power when repeated.
- **Body text contrast minimum**: `#0F1226` on `#F4F0E8` passes WCAG AA at 16px.

### Gradients (use sparingly)

- Hero background: `linear-gradient(180deg, #0F1226 0%, #1A1F3A 70%, #2D3458 100%)`
- Gold glow (radial, accent ornament only): `radial-gradient(circle, rgba(200,169,107,0.18) 0%, transparent 60%)`

---

## 4. Typography

### Font stack

```css
--font-display: 'Playfair Display', 'Cormorant Garamond', Georgia, serif;
--font-body: 'Manrope', 'Inter', -apple-system, system-ui, sans-serif;
```

Both from Google Fonts. Cyrillic support included (for future RU localization).

### Weights loaded

- Playfair Display: 400, 500, 700 + 400 italic, 500 italic
- Manrope: 300, 400, 500, 600, 700

### Type scale (desktop / mobile)

| Token | Desktop | Mobile | Font | Weight | Line height | Tracking |
|-------|---------|--------|------|--------|-------------|----------|
| `--text-display` | 96px | 56px | Playfair | 400 | 0.95 | -0.02em |
| `--text-h1` | 64px | 40px | Playfair | 400 | 1.0 | -0.02em |
| `--text-h2` | 48px | 32px | Playfair | 500 | 1.05 | -0.015em |
| `--text-h3` | 32px | 24px | Playfair | 500 | 1.15 | -0.01em |
| `--text-lede` | 20px | 17px | Manrope | 300 | 1.6 | 0 |
| `--text-body` | 16px | 16px | Manrope | 400 | 1.7 | 0 |
| `--text-small` | 14px | 14px | Manrope | 400 | 1.6 | 0.01em |
| `--text-eyebrow` | 11px | 11px | Manrope | 600 | 1 | 0.3em (uppercase) |
| `--text-meta` | 12px | 12px | Manrope | 500 | 1.4 | 0.05em |

### Display heading rules

- Italicise the **noun**, not the verb (e.g. *„Tamo gde **brdo** dotakne **zaliv**."*)
- Italic words always render in `--color-accent` (gold) on dark; primary on light.
- Never bold a Playfair heading — use weight 400 and let size carry the impact.
- Maximum 3 lines per display heading.

### Body rules

- Maximum measure: 64 characters per line.
- Paragraph spacing: 1em.
- No justified text. Left-aligned only.
- Lists use Manrope weight 400 with extra leading (1.8).

---

## 5. Layout & Spacing

### Grid

- 12-column grid, 80px gutters desktop, 24px gutters mobile.
- Max content width: 1280px.
- Edge padding: 40px desktop, 20px mobile.

### Vertical rhythm

- Section padding (top/bottom): **120px desktop / 64px mobile**.
- Hero section: full viewport height (`100vh`) on desktop, `auto` with min 700px on mobile.
- Element spacing within a component: 8 / 16 / 24 / 32 / 48 (multiples of 8).

### Section variety rule

Each section on a page must use a *different* layout pattern from its neighbour. Permitted patterns:

- **Hero** (asymmetric, headline-led)
- **2-column editorial** (text / image, alternates direction)
- **Quote pull** (large italic Playfair, no chrome)
- **Numbered list** (typographic, no icons)
- **Map embed** (full-width with framing inset)
- **Booking widget** (centered, isolated)
- **FAQ accordion** (single column, no decoration)

**Forbidden**: 3-column or 4-column icon-card grid (anti-box-method). If multiple features need to be shown, use alternating 2-column or a typographic numbered list.

### Hero composition

- Always centered or left-aligned headline.
- Eyebrow: gold rule line + small caps text + gold rule line.
- Headline: 3 lines max, italic gold noun anchors.
- Lede: max 480px wide.
- Single primary CTA + one ghost link maximum.
- Photography (if used): single image, never collage. If no quality photo: typography-only hero with a subtle gradient.

---

## 6. Components

### Button — Primary

```css
background: var(--color-accent);
color: var(--color-primary);
padding: 18px 36px;
font: 700 13px/1 var(--font-body);
letter-spacing: 0.2em;
text-transform: uppercase;
border-radius: 0;
transition: background 200ms ease;
```

Hover: `background: var(--color-accent-deep)`.
Never round. Never add a shadow. Never animate beyond color.

### Button — Ghost

```css
background: transparent;
color: var(--color-text-on-dark);
border: 1px solid var(--color-accent);
padding: 17px 35px;
```

### Eyebrow

```html
<div class="eyebrow">
  <span class="rule"></span> KUMBOR · BOKA KOTORSKA <span class="rule"></span>
</div>
```

Gold 1px rule lines flanking 11px uppercase tracked text. Always.

### Card (dark surface)

```css
background: linear-gradient(180deg, #1A1F3A, #2D3458);
border: 1px solid rgba(200,169,107,0.2);
padding: 40px;
border-radius: 0;
position: relative;
```

Pseudo-element top-left gold corner mark: 60px × 1px gold line at `top: 0; left: 0`.

### Booking widget mount

Centered, max-width 720px, light surface (`--color-bg`) with `--color-border` hairline frame. Title above in small caps eyebrow style: *„Recenzije gostiju · Booking.com"*. Widget itself (Booking.com embed script) styled minimally; brand chrome around it does the work.

---

## 7. Photography Direction

### Mood

Mediterranean coastal villa at the edge of golden hour. Warm undertones, deep shadows kept rich (not crushed). Vegetation reads as olive/sage rather than emerald. Sky leans warm at top, indigo at the horizon edge.

### Composition rules

- One subject per frame. No collages.
- Negative space is a feature. Crop tight on detail or wide on landscape — never the middle.
- People only as silhouettes or implied (a glass on a table, an open book).
- No staff in photos. No "smiling family" stock-style framing.

### Color grading (for existing daytime photos)

Apply uniformly across site:
- Lift shadows +5%, deepen contrast +10%
- Warm white balance +200K
- Desaturate greens -10%, saturate gold/orange +10%
- Subtle vignette (max 15% opacity at corners)

### Subjects to prioritize (homepage)

1. Terrace with view (any time of day, color-graded warm)
2. Bay of Kotor / Portonovi water view
3. Garden detail (olive branch, stone wall, table setting)
4. House exterior in hillside context

Avoid as homepage hero: bathroom, close-up interior of any single room, "amenity icon" style shots (a closeup of a remote control etc.).

---

## 8. Iconography & Ornament

### Star motif

The "star" in *Hill Star* is the brand's only mandatory symbolic element. Render as:
- A 4-point compass star (not a 5-point pop star, not a sheriff star)
- Gold (`--color-accent`)
- Used as: separator between words in stylized brand mark, ornament on footer, favicon glyph

### Rule lines

- 1px hairline gold rules above section headings (40–60px wide, decorative)
- Never use icons in lists. Use numerals (01 02 03) or simple dots.

### Forbidden

- Decorative icons (anchors, palm trees, suns, hearts, etc.)
- Photoshop effects: drop shadows, glow, bevel
- Gradients beyond the two specified in §3
- Emoji
- Rounded corners on anything

---

## 9. Imagery: Do / Don't

| Do | Don't |
|----|-------|
| Single hero photo, full-bleed, color-graded | Photo collage / "hero carousel" |
| Crop tight on architectural detail | Wide group shots of empty rooms |
| Editorial caption beneath images (italic Playfair) | Generic alt text or no caption |
| One photo per section maximum | Multiple thumbnails per section |
| Black-and-white emergency fallback (better than bad colour) | Lurid HDR / oversaturated colour |

---

## 10. Anti-patterns specific to this project

These are tempting and would damage the brand. Avoid:

1. **"Stay 3 nights, save 10%" banners** — undermines the premium positioning. Promotions belong on Booking.com, never on the site.
2. **Animated emoji or loading spinners** — kills cinema. Acceptable: a single fade or 200ms ease on interactive elements.
3. **Generic stock photography** — if a real photo doesn't exist, use type. Never download a stock image of "a couple on a beach".
4. **Booking forms with calendar pickers** — the entire booking flow lives on Booking.com. The site's job is to *make the user want to click through*.
5. **Awards / badges / "TripAdvisor recommended"** — even if true, the visual clutter dilutes the brand. The Booking widget itself is the only social proof.
6. **Family-friendly language** — this is for couples. Saying "great for families!" alienates the target audience.
7. **Multiple CTAs per section** — one primary action per screen, always.
8. **Generic amenity icons** (WiFi symbol, AC symbol, parking P) — these belong on Booking, not the brand site. List them as words.

---

## 11. Brand applications

### Logo lockup
Wordmark `HOUSE ★ HILL ★ STAR` in Playfair Display 500, tracked 0.06em, gold star separators. Minimum size 80px wide. Clear space = height of one capital letter on all sides.

(Three concept variations under review — see `logo-concepts.html`.)

### Domain & email
- Primary: `househillstar.com`
- Email signature: serif name + plain Manrope title + gold rule line

### Favicon
Single gold 4-point star on `#0F1226` background. 32×32 and 192×192.

### Social meta cards
- Open Graph image: 1200×630 dark hero with gold wordmark
- Twitter card: large summary, same image

### URL structure (multilingual)

```
househillstar.com/         → SR (default)
househillstar.com/en/      → English
househillstar.com/ru/      → Russian
```

### Booking CTA URL
All "Rezerviši" / "Book" / "Бронировать" buttons link to:
```
https://www.booking.com/hotel/me/house-hill-star-kumbor.sr.html
```
(localised variant per language: `.sr.html`, `.en-gb.html`, `.ru.html`)

---

## 12. Asset inventory (status)

| Asset | Status |
|-------|--------|
| Color tokens | ✓ Defined |
| Typography scale | ✓ Defined |
| Logo concepts | ⏳ In review (3 options) |
| Hero photography | ⚠ Existing daytime photos only — color grading required |
| Wordmark final | ⏳ Awaiting logo selection |
| Favicon | ⏳ Derives from final logo |
| Open Graph image | ⏳ Post-launch |
| EN translation | ⏳ Phase 2 |
| RU translation | ⏳ Phase 2 |

---

*This document is the source of truth for House Hill Star's visual identity. Any deviation requires explicit owner approval. Pass this brand book to any developer, photographer, or copywriter working on the project.*
