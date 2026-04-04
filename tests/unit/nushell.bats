#!/usr/bin/env bats
# Test nushell script syntax

load '../helpers/test_helper'

setup() {
  common_setup
  skip_if_no_command nu
}

@test "all nushell scripts pass syntax check" {
  local failed=0
  for f in "$HOME_SRC"/dot_config/nushell/*.nu; do
    [ -f "$f" ] || continue
    if ! nu --no-config-file -c "nu-check '$f'" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}
