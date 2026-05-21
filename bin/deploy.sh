#!/usr/bin/env bash
# ============================================================
# House Hill Star — Server-side deploy script
#
# Usage (from the project root on the cPanel server):
#   ./bin/deploy.sh
#
# What it does:
#   1. git pull latest from origin/main
#   2. npm install (only if package.json changed since last deploy)
#   3. npm run build (Astro → dist/)
#   4. rsync dist/ to PUBLIC_HTML (atomic-ish, preserves cPanel system files)
#   5. Trigger Cloudflare cache purge (if CF env vars set)
#
# Prerequisites on the server:
#   - Node.js 20+ available (enable via cPanel Node.js Selector or system install)
#   - rsync available (standard on cPanel)
#   - PUBLIC_HTML env var pointing to your public_html directory
#
# Optional Cloudflare cache purge:
#   export CF_ZONE_ID="..."
#   export CF_API_TOKEN="..."
# ============================================================

set -euo pipefail

# --- Configuration ---------------------------------------------------------
PUBLIC_HTML="${PUBLIC_HTML:-$HOME/public_html}"
BRANCH="${BRANCH:-main}"

# --- Helpers ---------------------------------------------------------------
log()   { printf '\033[1;36m[deploy]\033[0m %s\n' "$*"; }
fatal() { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

# --- Sanity checks ---------------------------------------------------------
[ -d ".git" ]        || fatal "Not a git repository. Run from project root."
[ -f "package.json" ] || fatal "package.json not found."
[ -d "$PUBLIC_HTML" ] || fatal "PUBLIC_HTML directory not found: $PUBLIC_HTML"

command -v node   >/dev/null || fatal "node not found. Enable Node.js Selector in cPanel."
command -v npm    >/dev/null || fatal "npm not found."
command -v rsync  >/dev/null || fatal "rsync not found."

# --- 1. Pull latest --------------------------------------------------------
log "Pulling latest from origin/$BRANCH…"
git fetch origin "$BRANCH"

PKG_HASH_BEFORE=$(sha1sum package.json | awk '{print $1}')

git reset --hard "origin/$BRANCH"

PKG_HASH_AFTER=$(sha1sum package.json | awk '{print $1}')

# --- 2. Install deps (only if package.json changed) ------------------------
if [ "$PKG_HASH_BEFORE" != "$PKG_HASH_AFTER" ] || [ ! -d "node_modules" ]; then
  log "package.json changed (or node_modules missing) — installing dependencies…"
  npm install --no-audit --no-fund
else
  log "package.json unchanged — skipping npm install."
fi

# --- 3. Build --------------------------------------------------------------
log "Building Astro site…"
npm run build

[ -f "dist/index.html" ] || fatal "Build produced no dist/index.html. Aborting."

BUILD_SIZE=$(du -sh dist/ | awk '{print $1}')
log "Build complete. Size: $BUILD_SIZE"

# --- 4. Sync to public_html ------------------------------------------------
log "Syncing dist/ → $PUBLIC_HTML"

# Build an exclude list so we don't blow away cPanel system files
EXCLUDES=(
  --exclude=cgi-bin/
  --exclude=.well-known/
  --exclude=.htaccess.bak
  --exclude=error_log
  --exclude=php_error_log
  --exclude=.cpanel/
  --exclude=.htpasswds/
)

rsync -av --delete "${EXCLUDES[@]}" dist/ "$PUBLIC_HTML/"

log "Sync complete."

# --- 5. Cloudflare cache purge (optional) ----------------------------------
if [ -n "${CF_ZONE_ID:-}" ] && [ -n "${CF_API_TOKEN:-}" ]; then
  log "Purging Cloudflare cache…"
  curl -fsS -X POST \
    "https://api.cloudflare.com/client/v4/zones/${CF_ZONE_ID}/purge_cache" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" \
    --data '{"purge_everything":true}' >/dev/null
  log "Cloudflare cache purged."
else
  log "Cloudflare env vars not set — skipping cache purge."
  log "  Set CF_ZONE_ID and CF_API_TOKEN in ~/.bashrc to enable."
fi

log "✅ Deploy finished. Site is live at https://househillstar.com"
