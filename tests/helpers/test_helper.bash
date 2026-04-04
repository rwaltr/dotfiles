#!/usr/bin/env bash
# Shared bats test helper for dotfiles test suite

# Project root (repo root)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
REPO_ROOT="$PROJECT_ROOT"

# Chezmoi source directory (per .chezmoiroot)
HOME_SRC="${PROJECT_ROOT}/home"
CHEZMOI_SOURCE="$HOME_SRC"

# Common setup - call from setup() in each .bats file
common_setup() {
  cd "$PROJECT_ROOT" || exit 1
}

# Skip test if a command is not available
skip_if_no_command() {
  local cmd="$1"
  if ! command -v "$cmd" &>/dev/null; then
    skip "$cmd not installed"
  fi
}

# Skip test if running in CI without chezmoi data
skip_if_no_chezmoi_data() {
  if ! chezmoi data &>/dev/null; then
    skip "chezmoi data not configured"
  fi
}

# Collect files matching a glob pattern under HOME_SRC
# Usage: mapfile -t files < <(find_files "dot_config/bashrc.d" "*.sh")
find_files() {
  local dir="$1"
  local pattern="$2"
  find "${HOME_SRC}/${dir}" -name "$pattern" -type f 2>/dev/null | sort
}

# Assert that a command succeeds for every file in a list
# Usage: assert_all_pass "bash -n" file1 file2 ...
assert_all_pass() {
  local cmd="$1"
  shift
  local failed=0
  local failures=""
  for f in "$@"; do
    if ! eval "$cmd \"$f\"" &>/dev/null; then
      failures+="  FAIL: $f"$'\n'
      failed=1
    fi
  done
  if [ "$failed" -eq 1 ]; then
    echo "$failures" >&2
    return 1
  fi
}
