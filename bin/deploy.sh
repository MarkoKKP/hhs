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
#   5. chown synced files to OWNER_USER:OWNER_GROUP (when running as root)
#   6. Trigger Cloudflare cache purge (if CF env vars set)
#
# Prerequisites on the server:
#   - Node.js 20+ available (enable via cPanel Node.js Selector or system install)
#   - rsync available (standard on cPanel)
#   - PUBLIC_HTML env var pointing to the target public_html directory
#   - OWNER_USER env var when running as root (e.g., "househil")
#
# Optional Cloudflare cache purge:
#   export CF_ZONE_ID="..."
#   export CF_API_TOKEN="..."
# ============================================================

set -euo pipefail

# --- Configuration ---------------------------------------------------------
PUBLIC_HTML="${PUBLIC_HTML:-$HOME/public_html}"
BRANCH="${BRANCH:-main}"
OWNER_USER="${OWNER_USER:-}"
OWNER_GROUP="${OWNER_GROUP:-$OWNER_USER}"
# Space-separated list of folder names inside PUBLIC_HTML to leave alone
# (not synced over, not chowned). Use for legacy backups, WordPress dirs, etc.
PRESERVE_DIRS="${PRESERVE_DIRS:-WPSITE}"

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

# Running as root requires OWNER_USER so synced files get correct ownership
RUNNING_AS_ROOT=0
if [ "$(id -u)" -eq 0 ]; then
  RUNNING_AS_ROOT=1
  [ -n "$OWNER_USER" ] || fatal "Running as root — set OWNER_USER (e.g., export OWNER_USER=househil) so synced files get correct ownership."
  id "$OWNER_USER" >/dev/null 2>&1 || fatal "OWNER_USER '$OWNER_USER' does not exist on this system."
fi

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

# Add project-specific preserve dirs (e.g., WPSITE backup)
for dir in $PRESERVE_DIRS; do
  EXCLUDES+=("--exclude=$dir/")
done

if [ -n "$PRESERVE_DIRS" ]; then
  log "Preserving directories (not touched): $PRESERVE_DIRS"
fi

rsync -av --delete "${EXCLUDES[@]}" dist/ "$PUBLIC_HTML/"

log "Sync complete."

# --- 5. Fix ownership when running as root ---------------------------------
if [ "$RUNNING_AS_ROOT" -eq 1 ]; then
  log "Setting ownership: $OWNER_USER:$OWNER_GROUP on $PUBLIC_HTML"

  # Build the find -not -path args dynamically — keeps cPanel system dirs
  # and any PRESERVE_DIRS untouched.
  FIND_EXCLUDES=(
    -not -path "$PUBLIC_HTML/cgi-bin*"
    -not -path "$PUBLIC_HTML/.well-known*"
    -not -path "$PUBLIC_HTML/.cpanel*"
    -not -path "$PUBLIC_HTML/.htpasswds*"
  )
  for dir in $PRESERVE_DIRS; do
    FIND_EXCLUDES+=( -not -path "$PUBLIC_HTML/$dir*" )
  done

  while IFS= read -r -d '' file; do
    chown -h "$OWNER_USER:$OWNER_GROUP" "$file"
  done < <(find "$PUBLIC_HTML" -mindepth 1 "${FIND_EXCLUDES[@]}" -print0)
fi

# --- 6. Cloudflare cache purge (optional) ----------------------------------
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
