#!/usr/bin/env bats
# WezTerm terminal configuration tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "wezterm: main config is valid lua" {
  run lua -e "loadfile('$CHEZMOI_SOURCE/dot_config/wezterm/wezterm.lua')"
  [ "$status" -eq 0 ]
}

@test "wezterm: utils.lua is valid lua" {
  run lua -e "loadfile('$CHEZMOI_SOURCE/dot_config/wezterm/utils.lua')"
  [ "$status" -eq 0 ]
}

@test "wezterm: platform configs are valid lua" {
  local failed=0
  while IFS= read -r f; do
    if ! lua -e "loadfile('$f')" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done < <(find "$CHEZMOI_SOURCE/dot_config/wezterm/platforms" -name '*.lua')
  [ "$failed" -eq 0 ]
}

@test "wezterm: config references wezterm API" {
  grep -q 'require.*wezterm\|wezterm.config_builder' "$CHEZMOI_SOURCE/dot_config/wezterm/wezterm.lua"
}

@test "wezterm: color schemes exist" {
  local colors_dir="$CHEZMOI_SOURCE/dot_config/wezterm/colors"
  if [ -d "$colors_dir" ]; then
    [ "$(find "$colors_dir" -type f | wc -l)" -gt 0 ]
  else
    skip "no custom color schemes"
  fi
}
