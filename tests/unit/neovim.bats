#!/usr/bin/env bats
# Neovim configuration tests

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "nvim: init.lua has valid syntax" {
  run lua -e "loadfile('$CHEZMOI_SOURCE/dot_config/nvim/init.lua')"
  [ "$status" -eq 0 ]
}

@test "nvim: all lua files have valid syntax" {
  local failed=0
  while IFS= read -r f; do
    if ! lua -e "loadfile('$f')" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done < <(find "$CHEZMOI_SOURCE/dot_config/nvim" -name '*.lua')
  [ "$failed" -eq 0 ]
}

@test "nvim: headless startup succeeds" {
  skip_if_no_command nvim
  run timeout 30 nvim --headless +"lua print('config-loaded')" +qa
  [ "$status" -eq 0 ]
  [[ "$output" == *"config-loaded"* ]]
}

@test "nvim: lazy.lua plugin spec parses" {
  local lazy
  lazy=$(find "$CHEZMOI_SOURCE/dot_config/nvim" -path '*/config/lazy.lua' -o -path '*/lazy.lua' | head -1)
  [ -n "$lazy" ] || skip "no lazy.lua found"
  run lua -e "loadfile('$lazy')"
  [ "$status" -eq 0 ]
}

@test "nvim: all plugin specs are valid lua" {
  local plugin_dir="$CHEZMOI_SOURCE/dot_config/nvim/lua/plugins"
  [ -d "$plugin_dir" ] || skip "no plugins dir"
  local failed=0
  while IFS= read -r f; do
    if ! lua -e "loadfile('$f')" 2>/dev/null; then
      echo "FAIL: $f" >&2
      failed=1
    fi
  done < <(find "$plugin_dir" -name '*.lua')
  [ "$failed" -eq 0 ]
}

@test "nvim: options config exists" {
  local opts
  opts=$(find "$CHEZMOI_SOURCE/dot_config/nvim" -path '*/config/options.lua' | head -1)
  [ -n "$opts" ]
  run lua -e "loadfile('$opts')"
  [ "$status" -eq 0 ]
}

@test "nvim: keymaps config exists" {
  local keymaps
  keymaps=$(find "$CHEZMOI_SOURCE/dot_config/nvim" -path '*/config/keymaps.lua' | head -1)
  [ -n "$keymaps" ]
  run lua -e "loadfile('$keymaps')"
  [ "$status" -eq 0 ]
}

@test "nvim: stylua.toml is valid" {
  local stylua="$CHEZMOI_SOURCE/dot_config/nvim/stylua.toml"
  [ -f "$stylua" ] || skip "no stylua.toml"
  run taplo check "$stylua"
  [ "$status" -eq 0 ]
}
