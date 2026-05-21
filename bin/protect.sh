#!/usr/bin/env bash
# ============================================================
# House Hill Star — Site protection (HTTP Basic Auth)
#
# Usage:
#   ./bin/protect.sh                        # use existing .htpasswd, just lock the site
#   ./bin/protect.sh username password      # create/overwrite .htpasswd, then lock
#   ./bin/protect.sh username               # prompt for password (hidden input)
#
# What it does:
#   1. Creates HTPASSWD_FILE if it doesn't exist (or rewrites it if creds provided)
#   2. Writes a locked .htaccess into PUBLIC_HTML with Basic Auth directives
#
# Env vars:
#   PUBLIC_HTML    — target directory (default: $HOME/public_html)
#   OWNER_USER     — when running as root, chown the files to this user
#   HTPASSWD_FILE  — where to store credentials (default: $HOME/.htpasswd_hhs)
# ============================================================

set -euo pipefail

PUBLIC_HTML="${PUBLIC_HTML:-$HOME/public_html}"
OWNER_USER="${OWNER_USER:-}"
HTPASSWD_FILE="${HTPASSWD_FILE:-$HOME/.htpasswd_hhs}"
AUTH_NAME="House Hill Star — Preview Access"

log()   { printf '\033[1;36m[protect]\033[0m %s\n' "$*"; }
fatal() { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

[ -d "$PUBLIC_HTML" ] || fatal "PUBLIC_HTML not found: $PUBLIC_HTML"

USERNAME="${1:-}"
PASSWORD="${2:-}"

# --- Create or update .htpasswd ---------------------------------------------
if [ -n "$USERNAME" ] || [ ! -f "$HTPASSWD_FILE" ]; then
  if [ -z "$USERNAME" ]; then
    read -r -p "Username: " USERNAME
  fi
  if [ -z "$PASSWORD" ]; then
    read -r -s -p "Password: " PASSWORD
    echo
  fi
  [ -n "$USERNAME" ] && [ -n "$PASSWORD" ] || fatal "Username and password required."

  # Prefer htpasswd binary; fall back to openssl APR1
  if command -v htpasswd >/dev/null 2>&1; then
    htpasswd -bc "$HTPASSWD_FILE" "$USERNAME" "$PASSWORD" >/dev/null
  elif command -v openssl >/dev/null 2>&1; then
    HASH=$(openssl passwd -apr1 "$PASSWORD")
    echo "$USERNAME:$HASH" > "$HTPASSWD_FILE"
  else
    fatal "Neither 'htpasswd' nor 'openssl' is available."
  fi

  chmod 644 "$HTPASSWD_FILE"
  log "Created/updated $HTPASSWD_FILE for user: $USERNAME"
else
  log "Reusing existing $HTPASSWD_FILE"
fi

# --- Write locked .htaccess -------------------------------------------------
log "Writing locked .htaccess to $PUBLIC_HTML"

cat > "$PUBLIC_HTML/.htaccess" <<EOF
# House Hill Star — Maintenance mode (LOCKED)
# Managed by bin/protect.sh / bin/publish.sh — do not edit directly.

AuthType Basic
AuthName "$AUTH_NAME"
AuthUserFile $HTPASSWD_FILE
Require valid-user

# Block search engines while locked
<IfModule mod_headers.c>
  Header set X-Robots-Tag "noindex, nofollow"
</IfModule>

DirectoryIndex index.html
EOF

# --- Fix ownership when running as root -------------------------------------
if [ "$(id -u)" -eq 0 ] && [ -n "$OWNER_USER" ]; then
  chown "$OWNER_USER:$OWNER_USER" "$PUBLIC_HTML/.htaccess"
  chown "$OWNER_USER:$OWNER_USER" "$HTPASSWD_FILE"
fi

log "✅ Site is now LOCKED — Basic Auth required at https://househillstar.com"
log "   To unlock for the public: ./bin/publish.sh"
