#!/usr/bin/env bats
# Test bash script syntax and sourcing

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "dot_bashrc has valid syntax" {
  bash -n "$HOME_SRC/dot_bashrc"
}

@test "all bashrc.d scripts have valid syntax" {
  local failed=0
  for f in "$HOME_SRC"/dot_config/bashrc.d/*.sh; do
    [ -f "$f" ] || continue
    if ! bash -n "$f" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "bashrc.d scripts can be sourced in isolation" {
  local failed=0
  local skipped=0
  for f in "$HOME_SRC"/dot_config/bashrc.d/*.sh; do
    [ -f "$f" ] || continue
    # Source in a subshell with minimal env, allow command-not-found (exit 127)
    local rc=0
    bash --norc --noprofile -c "
      # Stub out commands that may not exist
      command_not_found_handle() { return 0; }
      source '$f'
    " 2>/dev/null || rc=$?
    # 0 = ok, 1 = last command -v failed (acceptable), 127 = command not found
    if [ "$rc" -gt 1 ] && [ "$rc" -ne 127 ]; then
      echo "FAIL (exit $rc): $f" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "dot_bash_profile has valid syntax" {
  if [ -f "$HOME_SRC/dot_bash_profile" ]; then
    bash -n "$HOME_SRC/dot_bash_profile"
  else
    skip "no dot_bash_profile"
  fi
}

@test "executable shell scripts in dot_local/bin have valid syntax" {
  local found=0
  local failed=0
  for f in "$HOME_SRC"/dot_local/bin/executable_*.sh*; do
    [ -f "$f" ] || continue
    # Skip .tmpl files - they have template syntax
    [[ "$f" == *.tmpl ]] && continue
    found=1
    if ! bash -n "$f" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done
  if [ "$found" -eq 0 ]; then
    skip "no non-template shell scripts in dot_local/bin"
  fi
  [ "$failed" -eq 0 ]
}
