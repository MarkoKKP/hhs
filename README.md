# House Hill Star

Marketing site for House Hill Star — a private boutique vacation villa in Kumbor, Boka Kotorska, Montenegro.

**Stack**: Astro 4 (static) · trilingual (SR / EN / RU) · hosted on cPanel behind Cloudflare · server-pull deploy from GitHub.

**Live**: [househillstar.com](https://househillstar.com)
**Booking**: [House Hill Star on Booking.com](https://www.booking.com/hotel/me/house-hill-star-kumbor.sr.html)
**Repo**: [github.com/MarkoKKP/hhs](https://github.com/MarkoKKP/hhs)

---

## How the site works

1. Code is edited (by Claude or you) and pushed to GitHub `main`
2. GitHub Actions runs a CI build check — confirms the project builds cleanly
3. You SSH into the cPanel server and run `./bin/deploy.sh`
4. The script pulls latest, builds Astro, syncs `dist/` to `public_html/`, purges Cloudflare cache

No local Node.js. No FTP credentials in GitHub. All build happens on the server.

---

## One-time server setup

### Step 1 — Enable Node.js on the cPanel account

In cPanel: **Setup Node.js App** (or **Node.js Selector** depending on WHM config).
- Node version: **20.x**
- This just enables Node on the account — we don't actually create a Node app

After enabling, find which command activates Node in your SSH session. Common patterns:

```bash
# CloudLinux Node.js Selector — activate Node 20
source /opt/cpanel/ea-nodejs20/enable

# OR if alt-nodejs is installed:
source /opt/alt/alt-nodejs20/root/usr/bin/

# Verify
node --version  # should print v20.x.x
```

Add the `source ...` line to `~/.bashrc` so it activates on every login.

### Step 2 — Clone the repo on the server

SSH into the cPanel account and clone OUTSIDE of `public_html`:

```bash
ssh username@househillstar.com
cd ~                                              # home directory, NOT public_html
git clone https://github.com/MarkoKKP/hhs.git
cd hhs
chmod +x bin/deploy.sh
```

If the repo is private, use a personal access token or set up an SSH deploy key.

### Step 3 — Confirm `PUBLIC_HTML` path

The deploy script defaults to `$HOME/public_html`. If yours is different (addon domain, subdomain, etc.), set the env var:

```bash
echo 'export PUBLIC_HTML="$HOME/public_html"' >> ~/.bashrc
source ~/.bashrc
```

### Step 4 — (Optional) Configure Cloudflare cache purge

```bash
cat >> ~/.bashrc <<'EOF'
export CF_ZONE_ID="your-cloudflare-zone-id"
export CF_API_TOKEN="your-cloudflare-api-token"
EOF
source ~/.bashrc
```

- `CF_ZONE_ID`: Cloudflare → domain → Overview → right sidebar
- `CF_API_TOKEN`: <https://dash.cloudflare.com/profile/api-tokens> → custom token with **"Zone.Cache Purge"** permission for your zone

### Step 5 — First deploy

```bash
cd ~/hhs
./bin/deploy.sh
```

The script will:
1. `git fetch + reset` to latest `main`
2. `npm install` (first time only, or when `package.json` changes)
3. `npm run build` (Astro → `dist/`)
4. `rsync dist/ → public_html/` (preserves `cgi-bin/`, `.well-known/`, `.cpanel/`, etc.)
5. Purge Cloudflare cache (if configured)

Site is live within a couple minutes.

---

## Day-to-day updates

After the initial setup, every redeploy is one command:

```bash
ssh username@househillstar.com 'cd ~/hhs && ./bin/deploy.sh'
```

Or interactively:

```bash
ssh username@househillstar.com
cd ~/hhs
./bin/deploy.sh
```

---

## Auto-deploy (optional, advanced)

If you want pushes to GitHub to deploy automatically:

**Option A — GitHub webhook → cron poll**
Run a cron every minute that checks `git fetch` and runs deploy if there are new commits:

```cron
* * * * * cd ~/hhs && git fetch origin main && [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/main)" ] && ./bin/deploy.sh >> ~/deploy.log 2>&1
```

**Option B — GitHub webhook → small endpoint**
Set up a tiny PHP/CGI handler in `public_html/_hook.php` that verifies a secret and runs the deploy script.

We didn't ship this by default — too many environment-specific assumptions. Add it once you've confirmed the manual flow works.

---

## Repo layout

```
hhs/
├── .github/workflows/ci.yml      # GitHub Actions — build validation on push
├── bin/deploy.sh                 # Server-side deploy script (run on cPanel)
├── assets/photos/                # Source photos (interior/, terrace/, ...)
├── brand-book.md                 # Canonical brand reference (Hillside Twilight)
├── design-preview.html           # Initial 3 brand directions
├── logo-concepts.html            # 3 logo directions (Concept 01 chosen)
├── src/
│   ├── components/               # SiteHeader, SiteFooter
│   ├── i18n/ui.ts                # All UI strings + booking URLs per language
│   ├── layouts/BaseLayout.astro
│   ├── pages/index.astro         # SR homepage
│   └── styles/tokens.css         # Design tokens
├── public/favicon.svg
├── astro.config.mjs
├── package.json
├── README.md
└── CLAUDE.md
```

---

## Adding photos

1. Drop photos into `assets/photos/<subject>/` (`interior`, `terrace`, `garden`, `views`, `exterior`, `lifestyle`)
2. Follow the naming convention in `assets/photos/README.md`
3. Commit + push → run deploy on server

## Changing text

All visible text lives in `src/i18n/ui.ts`. Edit string, commit, push, deploy.

## Updating reviews

Review cards are static text in `src/i18n/ui.ts` (search for `review.1.quote`, `review.2.quote`, `review.3.quote`). Replace placeholders with real guest reviews.

---

## Logo

**Selected**: Concept 01 — The Star (dark variant). Wordmark `HOUSE ★ HILL ★ STAR` with gold 4-point star separators.
**Favicon**: gold star on indigo blue (`public/favicon.svg`).

See `logo-concepts.html` for all three concepts side by side.

---

## Brand book

See `brand-book.md` for the full Hillside Twilight specification — colors, typography, voice, components, anti-patterns. **Read it before any visual or copy change.**
