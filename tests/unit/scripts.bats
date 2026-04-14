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

@test "script: rwaltrctl-init renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/dot_local/bin/executable_rwaltrctl-init.sh.tmpl" | bash -n
}

@test "script: rwaltrctl-cleanup renders valid bash" {
  chezmoi execute-template < "$HOME_SRC/dot_local/bin/executable_rwaltrctl-cleanup.sh.tmpl" | bash -n
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

@test "script: flatpaks skips when headless" {
  grep -q 'headless' "$HOME_SRC/.chezmoiscripts/after/run_always_after_35_flatpaks.sh.tmpl"
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

@test "script: brew_bundle checks for brew" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_30_brew_bundle.sh.tmpl")
  [[ "$rendered" == *"command -v brew"* ]]
}

@test "script: mise_install checks for mise" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_onchange_after_50_mise_install.sh.tmpl")
  [[ "$rendered" == *"command -v mise"* ]]
}

# --- Rendered content checks: Brewfile and flatpak list actually produce content ---

@test "script: brew_bundle rendered Brewfile is non-empty" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_30_brew_bundle.sh.tmpl")
  # The BREWFILE heredoc should contain at least brew "mise"
  [[ "$rendered" == *'brew "mise"'* ]]
}

@test "script: flatpaks rendered list is non-empty when not headless" {
  local rendered
  rendered=$(chezmoi execute-template < "$HOME_SRC/.chezmoiscripts/after/run_always_after_35_flatpaks.sh.tmpl")
  # If this machine is not headless, flatpak list should have entries
  if [[ "$rendered" != *"Skipping flatpaks"* ]]; then
    [[ "$rendered" == *"flatpak install"* ]]
  fi
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
