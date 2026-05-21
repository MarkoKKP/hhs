#!/usr/bin/env bash
# ============================================================
# House Hill Star — Publish site (remove password gate)
#
# Usage:
#   ./bin/publish.sh           # asks for confirmation
#   ./bin/publish.sh --force   # no prompt
#
# What it does:
#   1. Removes gate.php from PUBLIC_HTML
#   2. Writes a clean .htaccess with cache headers (no auth rules)
#
# The GATE_CONFIG file (password hash) is preserved — re-locking with
# ./bin/protect.sh will reuse the existing password.
# ============================================================

set -euo pipefail

PUBLIC_HTML="${PUBLIC_HTML:-$HOME/public_html}"
OWNER_USER="${OWNER_USER:-}"

log()   { printf '\033[1;36m[publish]\033[0m %s\n' "$*"; }
fatal() { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

[ -d "$PUBLIC_HTML" ] || fatal "PUBLIC_HTML not found: $PUBLIC_HTML"

if [ "${1:-}" != "--force" ]; then
  read -r -p "⚠️  Going PUBLIC — site will be accessible to anyone on the internet. Continue? (y/N) " ans
  case "$ans" in y|Y|yes|YES) ;; *) log "Cancelled."; exit 0;; esac
fi

# --- Remove the gate -------------------------------------------------------
if [ -f "$PUBLIC_HTML/gate.php" ]; then
  rm -f "$PUBLIC_HTML/gate.php"
  log "Removed gate.php"
fi

# --- Write public .htaccess (no auth, with cache headers) ------------------
log "Writing public .htaccess to $PUBLIC_HTML"

cat > "$PUBLIC_HTML/.htaccess" <<'EOF'
# House Hill Star — PUBLIC
# Managed by bin/protect.sh / bin/publish.sh — do not edit directly.

DirectoryIndex index.html

# Long-cache content-hashed assets (Astro adds hashes to CSS/JS filenames)
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresByType text/css                  "access plus 1 year"
  ExpiresByType application/javascript    "access plus 1 year"
  ExpiresByType image/svg+xml             "access plus 1 month"
  ExpiresByType image/png                 "access plus 1 month"
  ExpiresByType image/jpeg                "access plus 1 month"
  ExpiresByType image/webp                "access plus 1 month"
  ExpiresByType font/woff2                "access plus 1 year"
</IfModule>

# Short-cache HTML so deploys appear quickly
<IfModule mod_headers.c>
  <FilesMatch "\.html$">
    Header set Cache-Control "public, max-age=300, must-revalidate"
  </FilesMatch>
</IfModule>

# Security headers
<IfModule mod_headers.c>
  Header set X-Content-Type-Options "nosniff"
  Header set X-Frame-Options "SAMEORIGIN"
  Header set Referrer-Policy "strict-origin-when-cross-origin"
</IfModule>
EOF

if [ "$(id -u)" -eq 0 ] && [ -n "$OWNER_USER" ]; then
  chown "$OWNER_USER:$OWNER_USER" "$PUBLIC_HTML/.htaccess"
fi

log "✅ Site is now PUBLIC at https://househillstar.com"
log "   To re-lock with password gate: ./bin/protect.sh"
