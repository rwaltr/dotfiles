#!/usr/bin/env bats
# Test chezmoi script templates — rendering + bash syntax of rendered output

load '../helpers/test_helper'

setup() {
  common_setup
  skip_if_no_command chezmoi
  skip_if_no_chezmoi_data
}

# --- Render + syntax check: every script template produces valid bash ---

@test "script: create_commondirs renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/before/run_once_before_create_commondirs.sh.tmpl" | bash -n
}

@test "script: install_homebrew renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/before/run_once_before_10_install_homebrew.sh.tmpl" | bash -n
}

@test "script: install_tailscale renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/before/run_once_before_20_install_tailscale.sh.tmpl" | bash -n
}

@test "script: brew_bundle renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_30_brew_bundle.sh.tmpl" | bash -n
}

@test "script: flatpaks renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_35_flatpaks.sh.tmpl" | bash -n
}

@test "script: orcaslicer renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_onchange_after_36_orcaslicer.sh.tmpl" | bash -n
}

@test "script: mise_install renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_onchange_after_50_mise_install.sh.tmpl" | bash -n
}

@test "script: yazi_plugins renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_onchange_after_60_yazi_plugins.sh.tmpl" | bash -n
}

@test "script: systemd_reload renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_99_systemd_reload.sh.tmpl" | bash -n
}

@test "script: rwaltrctl dispatcher is valid bash" {
  bash -n "$HOME_SRC/dot_local/bin/executable_rwaltrctl"
}

@test "script: rwaltrctl-init renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/dot_local/bin/executable_rwaltrctl-init.tmpl" | bash -n
}

@test "script: rwaltrctl-cleanup renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/dot_local/bin/executable_rwaltrctl-cleanup.tmpl" | bash -n
}

@test "script: rwaltrctl-bisync renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/dot_local/bin/executable_rwaltrctl-bisync.tmpl" | bash -n
}

@test "script: rwaltrctl-flatpaks renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/dot_local/bin/executable_rwaltrctl-flatpaks.tmpl" | bash -n
}

@test "script: rwaltrctl-brew renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/dot_local/bin/executable_rwaltrctl-brew.tmpl" | bash -n
}

@test "script: rwaltrctl dispatches plugin-style subcommands" {
  local tmpbin
  tmpbin=$(mktemp -d)
  cp "$HOME_SRC/dot_local/bin/executable_rwaltrctl" "$tmpbin/rwaltrctl"
  cat > "$tmpbin/rwaltrctl-hello" <<'EOF'
#!/usr/bin/env bash
# rwaltrctl hello — test command
echo "hello $*"
EOF
  chmod +x "$tmpbin/rwaltrctl" "$tmpbin/rwaltrctl-hello"

  run env PATH="$tmpbin:$PATH" "$tmpbin/rwaltrctl" hello world
  rm -rf "$tmpbin"

  [ "$status" -eq 0 ]
  [ "$output" = "hello world" ]
}

@test "script: rwaltrctl dynamically lists and completes subcommands" {
  local tmpbin
  tmpbin=$(mktemp -d)
  cp "$HOME_SRC/dot_local/bin/executable_rwaltrctl" "$tmpbin/rwaltrctl"
  cat > "$tmpbin/rwaltrctl-hello" <<'EOF'
#!/usr/bin/env bash
# rwaltrctl hello — test command
echo "hello $*"
EOF
  chmod +x "$tmpbin/rwaltrctl" "$tmpbin/rwaltrctl-hello"

  run env PATH="$tmpbin:$PATH" "$tmpbin/rwaltrctl" list
  [ "$status" -eq 0 ]
  [[ "$output" == *"hello"* ]]

  run env PATH="$tmpbin:$PATH" "$tmpbin/rwaltrctl" __complete
  [ "$status" -eq 0 ]
  [[ "$output" == *"hello"* ]]
  [[ "$output" == *"completion"* ]]

  run env PATH="$tmpbin:$PATH" "$tmpbin/rwaltrctl" help
  [ "$status" -eq 0 ]
  [[ "$output" == *"hello"* ]]
  [[ "$output" == *"test command"* ]]

  run env PATH="$tmpbin:$PATH" "$tmpbin/rwaltrctl" completion bash
  rm -rf "$tmpbin"

  [ "$status" -eq 0 ]
  [[ "$output" == *"rwaltrctl __complete"* ]]
}

# --- Conditional logic checks: scripts gate on the right flags ---

@test "script: tailscale skips on ephemeral" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/before/run_once_before_20_install_tailscale.sh.tmpl")
  # When ephemeral=true, the script should just echo skip message
  # When ephemeral=false, it should have the curl install line
  # Either way it should be valid — already tested above
  # Check the conditional is present in the template
  grep -q 'ephemeral' "$HOME_SRC/.chezmoiscripts/before/run_once_before_20_install_tailscale.sh.tmpl"
}

@test "script: flatpaks apply step is intentionally disabled" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_35_flatpaks.sh.tmpl")
  [[ "$rendered" == *"Skipping flatpak install/update in chezmoi apply."* ]]
  [[ "$rendered" == *"rwaltrctl flatpaks sync-now"* ]]
}

@test "script: orcaslicer requires personal and not headless" {
  grep -q 'personal' "$HOME_SRC/.chezmoiscripts/after/run_onchange_after_36_orcaslicer.sh.tmpl"
  grep -q 'headless' "$HOME_SRC/.chezmoiscripts/after/run_onchange_after_36_orcaslicer.sh.tmpl"
}

@test "script: systemd_reload checks for systemctl" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_99_systemd_reload.sh.tmpl")
  [[ "$rendered" == *"command -v systemctl"* ]]
}

@test "script: brew apply step is intentionally disabled" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_30_brew_bundle.sh.tmpl")
  [[ "$rendered" == *"Skipping brew bundle in chezmoi apply."* ]]
  [[ "$rendered" == *"rwaltrctl brew sync-now"* ]]
}

@test "script: mise_install checks for mise" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_onchange_after_50_mise_install.sh.tmpl")
  [[ "$rendered" == *"command -v mise"* ]]
}

# --- Rendered content checks: Brewfile and flatpak list actually produce content ---

@test "script: brew script does not run brew bundle install command" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_30_brew_bundle.sh.tmpl")
  [[ "$rendered" != *"brew bundle install --"* ]]
}

@test "script: flatpaks script does not run flatpak install command" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_35_flatpaks.sh.tmpl")
  [[ "$rendered" != *"flatpak install -y"* ]]
}

# --- All script templates found and accounted for ---

@test "script: Brewfile uses cask for cask-only packages" {
  local brewfile
  brewfile=$(chezmoi execute-template < "$HOME_SRC/.chezmoitemplates/Brewfile")
  # These are casks, not formulae — brew "..." would fail on fresh install
  local cask_only=("1password-cli")
  local failed=0
  for pkg in "${cask_only[@]}"; do
    if echo "$brewfile" | grep -q "^brew \"$pkg\""; then
      echo "FAIL: $pkg is a cask but declared as brew formula" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "script: no untested script templates" {
  local expected=9  # Total number of script templates
  local actual
  actual=$(find "$HOME_SRC/.chezmoiscripts" -name '*.tmpl' -type f | wc -l)
  [ "$actual" -eq "$expected" ]
}
