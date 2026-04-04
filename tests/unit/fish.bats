#!/usr/bin/env bats
# Test fish shell script syntax and conventions

load '../helpers/test_helper'

setup() {
  common_setup
  skip_if_no_command fish
}

@test "config.fish has valid syntax" {
  fish --no-execute "$HOME_SRC/dot_config/fish/config.fish"
}

@test "all conf.d scripts have valid syntax" {
  local failed=0
  for f in "$HOME_SRC"/dot_config/fish/conf.d/*.fish; do
    [ -f "$f" ] || continue
    if ! fish --no-execute "$f" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "all function files have valid syntax" {
  local failed=0
  for f in "$HOME_SRC"/dot_config/fish/functions/*.fish; do
    [ -f "$f" ] || continue
    if ! fish --no-execute "$f" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "function files define at least one function or abbr" {
  local failed=0
  for f in "$HOME_SRC"/dot_config/fish/functions/*.fish; do
    [ -f "$f" ] || continue
    # Each function file should contain at least one function definition or abbreviation
    if ! grep -qE '^\s*(function |abbr )' "$f"; then
      echo "FAIL: $f defines no function or abbr" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "no .fish files with syntax errors in completions (non-template)" {
  local failed=0
  local found=0
  for f in "$HOME_SRC"/dot_config/fish/completions/*.fish; do
    [ -f "$f" ] || continue
    # Skip template files
    [[ "$f" == *.tmpl ]] && continue
    found=1
    if ! fish --no-execute "$f" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done
  if [ "$found" -eq 0 ]; then
    skip "no non-template completion files"
  fi
  [ "$failed" -eq 0 ]
}
