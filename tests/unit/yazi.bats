#!/usr/bin/env bats
# Yazi file manager configuration tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "yazi: yazi.toml is valid TOML" {
  run taplo check "$CHEZMOI_SOURCE/dot_config/yazi/yazi.toml"
  [ "$status" -eq 0 ]
}

@test "yazi: keymap.toml is valid TOML" {
  run taplo check "$CHEZMOI_SOURCE/dot_config/yazi/keymap.toml"
  [ "$status" -eq 0 ]
}

@test "yazi: theme.toml is valid TOML" {
  run taplo check "$CHEZMOI_SOURCE/dot_config/yazi/theme.toml"
  [ "$status" -eq 0 ]
}
