#!/usr/bin/env bats
# Starship prompt configuration tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "starship: config is valid TOML" {
  run taplo check "$CHEZMOI_SOURCE/dot_config/starship.toml"
  [ "$status" -eq 0 ]
}

@test "starship: config defines a palette" {
  grep -q 'palette' "$CHEZMOI_SOURCE/dot_config/starship.toml"
}

@test "starship: config disables newline or sets prompt" {
  grep -qE '(add_newline|format|continuation_prompt)' "$CHEZMOI_SOURCE/dot_config/starship.toml"
}

@test "starship: referenced palette is defined" {
  local palette
  palette=$(grep '^palette' "$CHEZMOI_SOURCE/dot_config/starship.toml" | head -1 | sed 's/.*= *"//;s/".*//')
  [ -n "$palette" ]
  grep -q "\[palettes\.$palette\]" "$CHEZMOI_SOURCE/dot_config/starship.toml"
}

@test "starship: bash integration configured" {
  grep -rq 'starship init bash\|starship init' "$CHEZMOI_SOURCE/dot_config/bashrc.d/"
}

@test "starship: fish integration configured" {
  grep -rq 'starship init fish' "$CHEZMOI_SOURCE/dot_config/fish/"
}

@test "starship: preset validates with starship" {
  skip_if_no_command starship
  run starship preset --list
  [ "$status" -eq 0 ]
}
