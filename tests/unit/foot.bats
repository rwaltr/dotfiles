#!/usr/bin/env bats
# Foot terminal configuration tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "foot: config file exists" {
  [ -f "$CHEZMOI_SOURCE/dot_config/foot/foot.ini" ]
}

@test "foot: config has main and colors sections" {
  grep -q '^\[main\]' "$CHEZMOI_SOURCE/dot_config/foot/foot.ini"
  grep -q '^\[colors\]' "$CHEZMOI_SOURCE/dot_config/foot/foot.ini"
}
