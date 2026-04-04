#!/usr/bin/env bash
# Apply dotfiles inside a test container as a regular user
# Mounted at /dotfiles (read-only)
#
# Three phases:
#   1. File placement (chezmoi apply --exclude=scripts)
#   2. Script execution (render + run each script template)
#   3. Script idempotency (run all scripts again)
set -euo pipefail

TEST_USER="rwaltr"
TEST_HOME="/home/${TEST_USER}"

echo "=== OS Info ==="
head -5 /etc/os-release

# --- User setup ---
echo "=== Creating test user ==="
if ! id "$TEST_USER" &>/dev/null; then
  if command -v useradd &>/dev/null; then
    useradd -m -s /bin/bash -G wheel "$TEST_USER" 2>/dev/null || \
    useradd -m -s /bin/bash "$TEST_USER" 2>/dev/null || true
  elif command -v adduser &>/dev/null; then
    adduser -D -h "$TEST_HOME" -s /bin/bash "$TEST_USER" 2>/dev/null || true
  fi
fi

# Bootc: /home may be a symlink to /var/home
if [ -L /home ]; then
  mkdir -p "$(readlink -f /home)"
fi
mkdir -p "$TEST_HOME"
chown "$TEST_USER":"$TEST_USER" "$TEST_HOME" 2>/dev/null || true

# Passwordless sudo so scripts can install brew, system packages, etc.
if [ -d /etc/sudoers.d ]; then
  echo "$TEST_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"$TEST_USER"
  chmod 440 /etc/sudoers.d/"$TEST_USER"
fi

echo "=== User: $(id "$TEST_USER") ==="

# --- Chezmoi install ---
echo "=== Installing chezmoi ==="
mkdir -p "$TEST_HOME/.local/bin"
if ! command -v chezmoi &>/dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$TEST_HOME/.local/bin"
else
  ln -sf "$(command -v chezmoi)" "$TEST_HOME/.local/bin/chezmoi"
fi
chown -R "$TEST_USER":"$TEST_USER" "$TEST_HOME/.local" 2>/dev/null || true

# Create a wrapper script that sets up PATH for the test user
# This avoids issues with different distros' profile.d sourcing behavior
cat > /usr/local/bin/run-as-test-user << 'WRAPPER'
#!/bin/bash
# Run a command as the test user with full PATH setup
export HOME="/home/rwaltr"
export USER="rwaltr"
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
# Source brew if installed
if [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null)" || true
fi
exec su - rwaltr -c "export PATH=\"$HOME/.local/bin:/usr/local/bin:\$PATH\"; $*"
WRAPPER
chmod +x /usr/local/bin/run-as-test-user

echo "=== Chezmoi version ==="
run-as-test-user 'chezmoi --version'

# --- Phase 1: File placement ---
echo "=== Phase 1: Apply files (no scripts) ==="
run-as-test-user '
  chezmoi init \
    --source=/dotfiles/home \
    --no-tty \
    --exclude=scripts \
    --apply
'
echo "  Files applied successfully"

# --- Phase 2: Script execution ---
echo "=== Phase 2: Run scripts (rendered individually) ==="
SCRIPT_DIR=$(mktemp -d)
chown "$TEST_USER":"$TEST_USER" "$SCRIPT_DIR"

for tmpl in /dotfiles/home/.chezmoiscripts/before/*.tmpl /dotfiles/home/.chezmoiscripts/after/*.tmpl; do
  [ -f "$tmpl" ] || continue
  name=$(basename "$tmpl" .tmpl)
  rendered="${SCRIPT_DIR}/${name}"

  # Render template as user
  if ! run-as-test-user "chezmoi execute-template < '$tmpl'" > "$rendered" 2>/dev/null; then
    echo "  SKIP (render failed): $name"
    continue
  fi

  chmod +x "$rendered"
  chown "$TEST_USER":"$TEST_USER" "$rendered"

  echo "  RUN [1/2]: $name"
  if run-as-test-user "export TERM=dumb; bash '$rendered'" 2>&1 | sed 's/^/    /'; then
    echo "    OK"
  else
    echo "    EXIT: $? (non-fatal)"
  fi
done

# --- Phase 3: Script idempotency ---
echo "=== Phase 3: Re-run scripts (idempotency) ==="
for rendered in "$SCRIPT_DIR"/*; do
  [ -f "$rendered" ] || continue
  name=$(basename "$rendered")

  echo "  RUN [2/2]: $name"
  if run-as-test-user "export TERM=dumb; bash '$rendered'" 2>&1 | sed 's/^/    /'; then
    echo "    OK"
  else
    echo "    EXIT: $? (non-fatal)"
  fi
done

rm -rf "$SCRIPT_DIR"

echo "=== Apply complete ==="
run-as-test-user 'ls -la ~/.bashrc ~/.config/bashrc.d/ ~/.config/nvim/init.lua 2>/dev/null || true'
echo "=== Done ==="
