#!/usr/bin/env bats
# Television (tv) fuzzy finder configuration tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "tv: config.toml is valid TOML" {
  run taplo check "$CHEZMOI_SOURCE/dot_config/television/config.toml"
  [ "$status" -eq 0 ]
}

@test "tv: cable channel configs are valid TOML" {
  local cable_dir="$CHEZMOI_SOURCE/dot_config/television/cable"
  local failed=0
  while IFS= read -r f; do
    if ! taplo check "$f" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done < <(find "$cable_dir" -name '*.toml')
  [ "$failed" -eq 0 ]
}

@test "tv: config sets default_channel" {
  grep -q 'default_channel' "$CHEZMOI_SOURCE/dot_config/television/config.toml"
}
