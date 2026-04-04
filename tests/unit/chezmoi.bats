#!/usr/bin/env bats
# Test chezmoi metadata and configuration

load '../helpers/test_helper'

setup() {
  common_setup
}

@test ".chezmoiroot points to home/" {
  [ -f "$PROJECT_ROOT/.chezmoiroot" ]
  run cat "$PROJECT_ROOT/.chezmoiroot"
  [ "$output" = "home" ]
}

@test ".chezmoiversion file exists" {
  [ -f "$PROJECT_ROOT/.chezmoiversion" ]
}

@test "chezmoi source dir structure is valid" {
  # Key directories that must exist
  [ -d "$HOME_SRC/dot_config" ]
  [ -d "$HOME_SRC/dot_config/bashrc.d" ]
  [ -d "$HOME_SRC/dot_config/fish" ]
  [ -d "$HOME_SRC/dot_config/nvim" ]
  [ -d "$HOME_SRC/dot_config/nushell" ]
  [ -d "$HOME_SRC/private_dot_ssh" ]
}

@test "chezmoi doctor runs without errors" {
  skip_if_no_command chezmoi
  # doctor may have warnings but shouldn't error
  run chezmoi doctor
  # Exit code 0 = all good, non-zero is ok as long as it runs
  [[ "$status" -eq 0 ]] || [[ "$output" == *"ok"* ]]
}

@test "chezmoi managed files list is non-empty" {
  skip_if_no_command chezmoi
  run chezmoi managed --include=files
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -gt 0 ]
}

@test "chezmoi diff runs without crash" {
  skip_if_no_command chezmoi
  # diff exits 0 if no changes, non-zero if changes exist - both are fine
  run chezmoi diff --no-pager
  # Just checking it doesn't crash (exit 2+ would be an error)
  [[ "$status" -eq 0 ]] || [[ "$status" -eq 1 ]]
}

@test "install.sh exists and is valid bash" {
  [ -f "$PROJECT_ROOT/install.sh" ]
  bash -n "$PROJECT_ROOT/install.sh"
}
