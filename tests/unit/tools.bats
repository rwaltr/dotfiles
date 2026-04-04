#!/usr/bin/env bats
# Tool-specific config validation
# Tests for configs not large enough for their own file:
# bat, mpv, containers, go, kube, quickshell, bisync, resticprofile

load '../helpers/test_helper'

setup() {
  common_setup
}

# --- bat ---

@test "bat: config file exists" {
  [ -f "$CHEZMOI_SOURCE/dot_config/bat/config" ]
}

@test "bat: config sets theme" {
  grep -q 'theme' "$CHEZMOI_SOURCE/dot_config/bat/config"
}

# --- mpv ---

@test "mpv: config file exists" {
  [ -f "$CHEZMOI_SOURCE/dot_config/mpv/mpv.conf" ]
}

@test "mpv: config sets video output" {
  grep -q 'vo=' "$CHEZMOI_SOURCE/dot_config/mpv/mpv.conf"
}

@test "mpv: config enables hardware decoding" {
  grep -q 'hwdec' "$CHEZMOI_SOURCE/dot_config/mpv/mpv.conf"
}

# --- containers ---

@test "containers: config dir exists" {
  [ -d "$CHEZMOI_SOURCE/dot_config/containers" ]
}

# --- go ---

@test "go: env template renders GOPATH and GOBIN" {
  skip_if_no_command chezmoi
  local tmpl="$CHEZMOI_SOURCE/dot_config/go/env.tmpl"
  [ -f "$tmpl" ] || skip "no go env template"
  run chezmoi execute-template < "$tmpl"
  [ "$status" -eq 0 ]
  [[ "$output" == *"GOPATH"* ]]
  [[ "$output" == *"GOBIN"* ]]
}

# --- kube ---

@test "kube: clusters dir exists" {
  [ -d "$CHEZMOI_SOURCE/dot_config/kube/clusters" ]
}

@test "kube: bash kubectl aliases configured" {
  [ -f "$CHEZMOI_SOURCE/dot_config/bashrc.d/kubectl.sh" ]
  grep -qE 'alias k=|alias k ' "$CHEZMOI_SOURCE/dot_config/bashrc.d/kubectl.sh"
}

@test "kube: fish kubectl abbreviations configured" {
  grep -rq 'kubectl\|kubecolor' "$CHEZMOI_SOURCE/dot_config/fish/"
}

# --- bisync ---

@test "bisync: templates all render" {
  skip_if_no_command chezmoi
  local failed=0
  while IFS= read -r f; do
    if ! chezmoi execute-template < "$f" >/dev/null 2>&1; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done < <(find "$CHEZMOI_SOURCE/dot_config/bisync" -name '*.tmpl' 2>/dev/null)
  [ "$failed" -eq 0 ]
}

@test "bisync: systemd service references rclone" {
  local svc="$CHEZMOI_SOURCE/dot_config/systemd/user/bisync@.service"
  [ -f "$svc" ] || skip "no bisync service"
  grep -q 'rclone\|bisync' "$svc"
}

# --- resticprofile ---

@test "resticprofile: template renders valid TOML" {
  skip_if_no_command chezmoi
  local tmpl="$CHEZMOI_SOURCE/dot_config/resticprofile/profiles.toml.tmpl"
  [ -f "$tmpl" ] || skip "no resticprofile template"
  run chezmoi execute-template < "$tmpl"
  [ "$status" -eq 0 ]
  echo "$output" | python3 -c "import tomllib,sys; tomllib.load(sys.stdin.buffer)"
}

@test "resticprofile: systemd timer exists" {
  [ -f "$CHEZMOI_SOURCE/dot_config/systemd/user/resticprofile@home.timer" ] || \
  skip "no resticprofile timer"
}
