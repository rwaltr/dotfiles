#!/usr/bin/env bats
# Atuin shell history configuration tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "atuin: config is valid TOML" {
  run taplo check --no-schema "$CHEZMOI_SOURCE/dot_config/private_atuin/private_config.toml"
  [ "$status" -eq 0 ]
}

@test "atuin: config file is non-empty" {
  [ -s "$CHEZMOI_SOURCE/dot_config/private_atuin/private_config.toml" ]
}
