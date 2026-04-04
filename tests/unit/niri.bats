#!/usr/bin/env bats
# Niri Wayland compositor configuration tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "niri: config.kdl exists (entrypoint)" {
  [ -f "$CHEZMOI_SOURCE/dot_config/niri/config.kdl" ]
}

@test "niri: local.kdl exists (user overrides)" {
  [ -f "$CHEZMOI_SOURCE/dot_config/niri/local.kdl" ]
}

@test "niri: config.kdl includes local.kdl" {
  grep -q 'include.*local.kdl' "$CHEZMOI_SOURCE/dot_config/niri/config.kdl"
}

@test "niri: local.kdl defines keybindings" {
  grep -q 'binds' "$CHEZMOI_SOURCE/dot_config/niri/local.kdl"
}

@test "niri: local.kdl defines layout" {
  grep -qE '(layout|default-column-width)' "$CHEZMOI_SOURCE/dot_config/niri/local.kdl"
}

@test "niri: local.kdl defines outputs" {
  grep -q 'output' "$CHEZMOI_SOURCE/dot_config/niri/local.kdl"
}

@test "niri: config.kdl includes DMS overlay" {
  grep -q 'include.*dms.kdl' "$CHEZMOI_SOURCE/dot_config/niri/config.kdl"
}
