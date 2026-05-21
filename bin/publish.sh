#!/usr/bin/env bash
# ============================================================
# House Hill Star — Make site PUBLIC (remove Basic Auth)
#
# Usage:
#   ./bin/publish.sh           # prompts for confirmation
#   ./bin/publish.sh --force   # skip confirmation
#
# What it does:
#   Writes an unlocked .htaccess into PUBLIC_HTML (auth directives removed).
#   The .htpasswd file is left in place — re-locking is just ./bin/protect.sh.
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

log "Writing public .htaccess to $PUBLIC_HTML"

cat > "$PUBLIC_HTML/.htaccess" <<'EOF'
# House Hill Star — PUBLIC
# Managed by bin/protect.sh / bin/publish.sh — do not edit directly.

DirectoryIndex index.html

# Long-cache static assets (CSS/JS/images) — they're content-hashed by Astro
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

# Short-cache HTML so updates appear quickly
<IfModule mod_headers.c>
  <FilesMatch "\.html$">
    Header set Cache-Control "public, max-age=300, must-revalidate"
  </FilesMatch>
</IfModule>
EOF

if [ "$(id -u)" -eq 0 ] && [ -n "$OWNER_USER" ]; then
  chown "$OWNER_USER:$OWNER_USER" "$PUBLIC_HTML/.htaccess"
fi

log "✅ Site is now PUBLIC at https://househillstar.com"
log "   To re-lock: ./bin/protect.sh"
