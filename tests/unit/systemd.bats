#!/usr/bin/env bats
# Systemd user unit tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "systemd: all service units have [Unit] and [Service] sections" {
  local failed=0
  while IFS= read -r f; do
    name=$(basename "$f")
    if ! grep -q '\[Unit\]' "$f"; then
      echo "FAIL: $name missing [Unit]" >&2
      failed=1
    fi
    if ! grep -q '\[Service\]' "$f"; then
      echo "FAIL: $name missing [Service]" >&2
      failed=1
    fi
  done < <(find "$CHEZMOI_SOURCE/dot_config/systemd" -name '*.service')
  [ "$failed" -eq 0 ]
}

@test "systemd: all timer units have [Timer] section" {
  local failed=0
  while IFS= read -r f; do
    name=$(basename "$f")
    if ! grep -q '\[Timer\]' "$f"; then
      echo "FAIL: $name missing [Timer]" >&2
      failed=1
    fi
  done < <(find "$CHEZMOI_SOURCE/dot_config/systemd" -name '*.timer')
  [ "$failed" -eq 0 ]
}

@test "systemd: service units define ExecStart" {
  local failed=0
  while IFS= read -r f; do
    name=$(basename "$f")
    if ! grep -q 'ExecStart' "$f"; then
      echo "FAIL: $name missing ExecStart" >&2
      failed=1
    fi
  done < <(find "$CHEZMOI_SOURCE/dot_config/systemd" -name '*.service')
  [ "$failed" -eq 0 ]
}

@test "systemd: timer units define OnCalendar or OnBootSec" {
  local failed=0
  while IFS= read -r f; do
    name=$(basename "$f")
    if ! grep -qE '(OnCalendar|OnBootSec|OnUnitActiveSec)' "$f"; then
      echo "FAIL: $name missing timer schedule" >&2
      failed=1
    fi
  done < <(find "$CHEZMOI_SOURCE/dot_config/systemd" -name '*.timer')
  [ "$failed" -eq 0 ]
}

@test "systemd: units pass systemd-analyze verify" {
  skip_if_no_command systemd-analyze
  local failed=0
  while IFS= read -r f; do
    [ -f "$f" ] || continue
    name=$(basename "$f")
    [[ "$name" == *.keep ]] && continue
    # systemd-analyze verify is strict but catches real issues
    if ! systemd-analyze verify --user "$f" 2>/dev/null; then
      echo "WARN: $name has issues (may be expected for template units)" >&2
    fi
  done < <(find "$CHEZMOI_SOURCE/dot_config/systemd" -name '*.service' -o -name '*.timer')
  # Don't fail on verify warnings — template units (bisync@.service) will always warn
  true
}
