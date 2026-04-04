#!/usr/bin/env bats
# Root-level and cross-cutting config validation
# Tool-specific configs live in their own test files

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "mise config.toml is valid TOML" {
  run taplo check "$CHEZMOI_SOURCE/dot_config/mise/config.toml"
  [ "$status" -eq 0 ]
}

@test "root mise.toml is valid TOML" {
  run taplo check "$REPO_ROOT/mise.toml"
  [ "$status" -eq 0 ]
}

@test ".sops.yaml is valid YAML" {
  run yamllint -d relaxed "$REPO_ROOT/.sops.yaml"
  [ "$status" -eq 0 ]
}

@test ".chezmoiexternal.yaml is valid YAML" {
  local ext="$CHEZMOI_SOURCE/.chezmoiexternal.yaml"
  [ -f "$ext" ] || skip "no .chezmoiexternal.yaml"
  run yamllint -d relaxed "$ext"
  [ "$status" -eq 0 ]
}

@test "install.sh exists and is valid bash" {
  [ -f "$REPO_ROOT/install.sh" ] || skip "no install.sh"
  run bash -n "$REPO_ROOT/install.sh"
  [ "$status" -eq 0 ]
}
