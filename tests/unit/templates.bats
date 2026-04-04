#!/usr/bin/env bats
# Test chezmoi template rendering
# Every .tmpl file should render without error via execute-template
# (except .chezmoi.yaml.tmpl which uses init-only functions)

load '../helpers/test_helper'

setup() {
  common_setup
  skip_if_no_command chezmoi
}

# --- Individual template output validation ---

@test "template: symlink_dot_bin renders path to .local/bin" {
  run chezmoi execute-template < "$HOME_SRC/symlink_dot_bin.tmpl"
  [ "$status" -eq 0 ]
  [[ "$output" == *"/.local/bin"* ]]
}

@test "template: git config renders [user] section" {
  skip_if_no_chezmoi_data
  run chezmoi execute-template < "$HOME_SRC/dot_config/git/config.tmpl"
  [ "$status" -eq 0 ]
  [[ "$output" == *"[user]"* ]]
  [[ "$output" == *"name ="* ]]
  [[ "$output" == *"email ="* ]]
}

@test "template: git config renders valid git config syntax" {
  skip_if_no_chezmoi_data
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/dot_config/git/config.tmpl")
  # Write to temp and parse
  local tmp
  tmp=$(mktemp)
  echo "$rendered" > "$tmp"
  git config --file "$tmp" --list >/dev/null
  rm -f "$tmp"
}

@test "template: ssh config renders host entries" {
  run chezmoi execute-template < "$HOME_SRC/private_dot_ssh/private_config.tmpl"
  [ "$status" -eq 0 ]
  [[ "$output" == *"host *"* ]]
  [[ "$output" == *"github.com"* ]]
  [[ "$output" == *"ControlMaster"* ]]
}

@test "template: go env renders GOBIN and GOPATH" {
  run chezmoi execute-template < "$HOME_SRC/dot_config/go/env.tmpl"
  [ "$status" -eq 0 ]
  [[ "$output" == *"GOBIN="* ]]
  [[ "$output" == *"GOPATH="* ]]
}

@test "template: bisync templates all render" {
  skip_if_no_chezmoi_data
  local failed=0
  for f in "$HOME_SRC"/dot_config/bisync/*.tmpl; do
    [ -f "$f" ] || continue
    if ! chezmoi execute-template < "$f" >/dev/null 2>&1; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "template: resticprofile renders valid TOML syntax" {
  skip_if_no_chezmoi_data
  skip_if_no_command taplo
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/dot_config/resticprofile/profiles.toml.tmpl")
  # Strip the schema comment — we're testing TOML syntax, not schema conformance
  local tmp
  tmp=$(mktemp --suffix=.toml)
  echo "$rendered" | grep -v '^#:schema' > "$tmp"
  python3 -c "import tomllib; tomllib.load(open('$tmp','rb'))"
  rm -f "$tmp"
}

@test "template: resticprofile contains hostname" {
  skip_if_no_chezmoi_data
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/dot_config/resticprofile/profiles.toml.tmpl")
  local hostname
  hostname=$(chezmoi data | grep '"hostname"' | head -1 | cut -d'"' -f4)
  [[ "$rendered" == *"$hostname"* ]]
}

@test "template: sops/age renders without secrets" {
  # This template is conditional on .personal — either way it should render
  # and must NOT contain plaintext AGE-SECRET-KEY
  run chezmoi execute-template < "$HOME_SRC/dot_config/sops/age/private_keys.txt.tmpl"
  [ "$status" -eq 0 ]
  [[ "$output" != *"AGE-SECRET-KEY-"* ]]
}

@test "template: fish completions render or gracefully empty" {
  # These use lookPath + output — if tool exists, renders completions; otherwise empty
  local failed=0
  for f in "$HOME_SRC"/dot_config/fish/completions/*.tmpl; do
    [ -f "$f" ] || continue
    if ! chezmoi execute-template < "$f" >/dev/null 2>&1; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "template: fish completions for installed tools produce output" {
  # If chezmoi is installed (it is), its completion template should produce content
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/dot_config/fish/completions/chezmoi.fish.tmpl")
  [[ -n "$rendered" ]]
  [[ "$rendered" == *"function"* ]]
}

@test "template: authorized_keys renders (may be empty if not personal)" {
  run chezmoi execute-template < "$HOME_SRC/private_dot_ssh/private_authorized_keys.tmpl"
  [ "$status" -eq 0 ]
}

@test "template: chezmoi.yaml.tmpl" {
  # Uses stdinIsATTY and promptBoolOnce — only available during 'chezmoi init'
  skip "uses init-only functions (stdinIsATTY, promptBoolOnce)"
}

# --- Catch-all: every template renders ---

@test "template: ALL templates render without crash" {
  skip_if_no_chezmoi_data
  local failed=0
  local skip_patterns=(
    ".chezmoi.yaml"    # init-only functions (stdinIsATTY, promptBoolOnce)
  )
  while IFS= read -r f; do
    local should_skip=false
    for pat in "${skip_patterns[@]}"; do
      if [[ "$f" == *"$pat"* ]]; then
        should_skip=true
        break
      fi
    done
    $should_skip && continue

    if ! chezmoi execute-template < "$f" >/dev/null 2>&1; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done < <(find "$HOME_SRC" -name '*.tmpl' -type f)
  [ "$failed" -eq 0 ]
}
