#!/usr/bin/env bash
# ============================================================
# House Hill Star — Branded password gate (lock the site)
#
# Usage:
#   ./bin/protect.sh                    # uses existing password (if config exists)
#   ./bin/protect.sh "mojaLozinka"      # sets new password
#
# What it does:
#   1. Creates GATE_CONFIG file (PHP) with APR1 password hash (outside public_html)
#   2. Writes gate.php into public_html — on-brand password input page
#   3. Writes .htaccess rewrite rules: all requests without auth cookie → gate.php
#
# When a visitor:
#   - Doesn't have the access cookie → sees the branded password form
#   - Types correct password → cookie set for 30 days → redirected to homepage
#   - Has valid cookie → goes straight to static site (gate.php not loaded)
#
# Env vars:
#   PUBLIC_HTML    — target directory (default: $HOME/public_html)
#   OWNER_USER     — chown target user when running as root
#   GATE_CONFIG    — password config file path (default: $HOME/.hhs-gate.conf)
# ============================================================

set -euo pipefail

PUBLIC_HTML="${PUBLIC_HTML:-$HOME/public_html}"
OWNER_USER="${OWNER_USER:-}"
GATE_CONFIG="${GATE_CONFIG:-$HOME/.hhs-gate.conf}"

log()   { printf '\033[1;36m[protect]\033[0m %s\n' "$*"; }
fatal() { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

[ -d "$PUBLIC_HTML" ] || fatal "PUBLIC_HTML not found: $PUBLIC_HTML"
command -v openssl >/dev/null || fatal "openssl required for password hashing"

PASSWORD="${1:-}"

# --- Create or update config file ------------------------------------------
if [ -n "$PASSWORD" ] || [ ! -f "$GATE_CONFIG" ]; then
  if [ -z "$PASSWORD" ]; then
    read -r -s -p "New password: " PASSWORD; echo
  fi
  [ -n "$PASSWORD" ] || fatal "Password cannot be empty."

  HASH=$(openssl passwd -apr1 "$PASSWORD")

  cat > "$GATE_CONFIG" <<EOF
<?php
// House Hill Star — password gate config (managed by bin/protect.sh)
\$GATE_PASSWORD_HASH = '$HASH';
\$GATE_COOKIE_NAME   = 'hhs_access';
\$GATE_COOKIE_DAYS   = 30;
EOF
  chmod 644 "$GATE_CONFIG"
  log "Saved password hash to $GATE_CONFIG"
else
  log "Using existing config: $GATE_CONFIG"
fi

# --- Write gate.php (branded password page) --------------------------------
log "Writing gate.php to $PUBLIC_HTML"

cat > "$PUBLIC_HTML/gate.php" <<'PHPEOF'
<?php
require '__GATE_CONFIG__';

$error = null;
$is_https = (
    (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ||
    (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https')
);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $password = $_POST['password'] ?? '';
    if (!empty($password) && crypt($password, $GATE_PASSWORD_HASH) === $GATE_PASSWORD_HASH) {
        setcookie($GATE_COOKIE_NAME, 'valid', [
            'expires'  => time() + 60 * 60 * 24 * $GATE_COOKIE_DAYS,
            'path'     => '/',
            'secure'   => $is_https,
            'httponly' => true,
            'samesite' => 'Lax',
        ]);
        $next = (isset($_GET['next']) && preg_match('/^\/[^\s]*$/', $_GET['next'])) ? $_GET['next'] : '/';
        header('Location: ' . $next);
        exit;
    }
    $error = 'Pogrešna lozinka.';
}
?>
<!DOCTYPE html>
<html lang="sr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>House Hill Star — Pristup u pripremi</title>
<meta name="robots" content="noindex,nofollow">
<link rel="icon" type="image/svg+xml" href="/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,500;1,400;1,500&family=Manrope:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root {
    --primary: #0F1226;
    --accent: #C8A96B;
    --accent-deep: #9C8048;
    --text: #F4F0E8;
    --muted: #A8A3B8;
    --border: rgba(200,169,107,0.25);
    --danger: #d4634a;
  }
  *, *::before, *::after { box-sizing: border-box; }
  html, body { margin: 0; padding: 0; height: 100%; }
  body {
    font-family: 'Manrope', sans-serif;
    background: linear-gradient(180deg, #0F1226 0%, #1A1F3A 70%, #2D3458 100%);
    color: var(--text);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 24px;
    position: relative;
    overflow: hidden;
    -webkit-font-smoothing: antialiased;
  }
  .glow {
    position: absolute;
    top: -200px;
    right: -200px;
    width: 700px;
    height: 700px;
    background: radial-gradient(circle, rgba(200,169,107,0.18), transparent 60%);
    pointer-events: none;
  }
  .gate {
    position: relative;
    z-index: 2;
    max-width: 440px;
    width: 100%;
    text-align: center;
  }
  .logo {
    font-family: 'Playfair Display', serif;
    font-size: 18px;
    font-weight: 500;
    letter-spacing: 0.06em;
    display: inline-flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 56px;
  }
  .logo .star {
    width: 14px;
    height: 14px;
    flex: 0 0 14px;
  }
  .eyebrow {
    font-family: 'Manrope', sans-serif;
    font-size: 11px;
    letter-spacing: 0.3em;
    text-transform: uppercase;
    color: var(--accent);
    font-weight: 600;
    margin-bottom: 28px;
    display: inline-flex;
    align-items: center;
    gap: 16px;
  }
  .eyebrow::before, .eyebrow::after {
    content: '';
    width: 32px;
    height: 1px;
    background: var(--accent);
  }
  h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(36px, 6vw, 56px);
    font-weight: 400;
    line-height: 1.05;
    letter-spacing: -0.02em;
    margin: 0 0 24px;
  }
  h1 em {
    font-style: italic;
    color: var(--accent);
    font-weight: 500;
  }
  .lede {
    font-family: 'Manrope', sans-serif;
    font-size: 16px;
    line-height: 1.65;
    color: var(--muted);
    margin: 0 auto 40px;
    max-width: 360px;
    font-weight: 300;
  }
  form { display: flex; flex-direction: column; gap: 14px; }
  input[type="password"] {
    background: rgba(255,255,255,0.04);
    border: 1px solid var(--border);
    color: var(--text);
    font-family: 'Manrope', sans-serif;
    font-size: 16px;
    padding: 18px 20px;
    outline: none;
    transition: border-color 200ms ease, background 200ms ease;
    text-align: center;
    letter-spacing: 0.1em;
  }
  input[type="password"]:focus {
    border-color: var(--accent);
    background: rgba(255,255,255,0.06);
  }
  input[type="password"]::placeholder {
    color: var(--muted);
    letter-spacing: 0.15em;
    text-transform: uppercase;
    font-size: 12px;
  }
  button {
    background: var(--accent);
    color: var(--primary);
    font-family: 'Manrope', sans-serif;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    padding: 18px 32px;
    border: 0;
    cursor: pointer;
    transition: background 200ms ease;
  }
  button:hover { background: var(--accent-deep); }
  .error {
    font-family: 'Playfair Display', serif;
    font-style: italic;
    color: var(--danger);
    margin: 0 0 16px;
    font-size: 15px;
  }
  .footer-note {
    margin-top: 64px;
    font-family: 'Manrope', sans-serif;
    font-size: 11px;
    letter-spacing: 0.3em;
    text-transform: uppercase;
    color: var(--muted);
    opacity: 0.7;
  }
</style>
</head>
<body>
<div class="glow" aria-hidden="true"></div>
<main class="gate">
  <div class="logo">
    <span>HOUSE</span>
    <svg class="star" viewBox="0 0 24 24" fill="#C8A96B" aria-hidden="true"><polygon points="12,0 14.5,9.5 24,12 14.5,14.5 12,24 9.5,14.5 0,12 9.5,9.5"/></svg>
    <span>HILL</span>
    <svg class="star" viewBox="0 0 24 24" fill="#C8A96B" aria-hidden="true"><polygon points="12,0 14.5,9.5 24,12 14.5,14.5 12,24 9.5,14.5 0,12 9.5,9.5"/></svg>
    <span>STAR</span>
  </div>

  <div class="eyebrow">Pregled u pripremi</div>
  <h1>Sajt je <em>uskoro</em><br>dostupan.</h1>
  <p class="lede">Trenutno je u privatnoj fazi pregleda. Unesite šifru da nastavite.</p>

  <?php if (!empty($error)): ?>
    <p class="error"><?= htmlspecialchars($error) ?></p>
  <?php endif; ?>

  <form method="POST" autocomplete="off">
    <input type="password" name="password" placeholder="Šifra" autocomplete="current-password" autofocus required>
    <button type="submit">Uđi</button>
  </form>

  <p class="footer-note">Kumbor · Boka Kotorska</p>
</main>
</body>
</html>
PHPEOF

# Substitute config path into gate.php
sed -i "s|__GATE_CONFIG__|$GATE_CONFIG|g" "$PUBLIC_HTML/gate.php"

# --- Write .htaccess (rewrite + noindex) -----------------------------------
log "Writing locked .htaccess to $PUBLIC_HTML"

cat > "$PUBLIC_HTML/.htaccess" <<'EOF'
# House Hill Star — Maintenance mode (LOCKED with password gate)
# Managed by bin/protect.sh / bin/publish.sh — do not edit directly.

RewriteEngine On

# Don't rewrite the gate itself or the favicon (so the gate page can render)
RewriteCond %{REQUEST_URI} !^/gate\.php$
RewriteCond %{REQUEST_URI} !^/favicon\.svg$
# Don't rewrite if the user already passed the gate
RewriteCond %{HTTP_COOKIE} !hhs_access=valid
# Everything else → gate.php (preserve original URL as ?next=)
RewriteRule .* /gate.php?next=%{REQUEST_URI} [L,QSA]

# Block search engines while locked
<IfModule mod_headers.c>
  Header set X-Robots-Tag "noindex, nofollow"
</IfModule>

DirectoryIndex index.html index.php
EOF

# --- Fix ownership when running as root ------------------------------------
if [ "$(id -u)" -eq 0 ] && [ -n "$OWNER_USER" ]; then
  chown "$OWNER_USER:$OWNER_USER" "$PUBLIC_HTML/.htaccess" "$PUBLIC_HTML/gate.php" "$GATE_CONFIG"
fi

log "✅ Site is LOCKED behind branded password gate at https://househillstar.com"
log "   To open to the public: ./bin/publish.sh"
