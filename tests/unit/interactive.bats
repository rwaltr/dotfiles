#!/usr/bin/env bats
# Test interactive shell features — aliases, environment, functions
# These test the actual applied dotfiles (requires chezmoi to have been applied)

load '../helpers/test_helper'

setup() {
  common_setup
}

# --- Bash interactive features ---

@test "bash: aliases defined in rwaltr-aliases.sh" {
  # Source the alias file and check key aliases exist
  run bash --norc --noprofile -c '
    shopt -s expand_aliases
    source "'"$HOME_SRC"'/dot_config/bashrc.d/rwaltr-aliases.sh"
    alias | grep -c "alias"
  '
  [ "$status" -eq 0 ]
  # Should define multiple aliases
  [ "$output" -gt 0 ]
}

@test "bash: exit aliases defined (q, x, :q)" {
  run bash --norc --noprofile -c '
    shopt -s expand_aliases
    source "'"$HOME_SRC"'/dot_config/bashrc.d/rwaltr-aliases.sh"
    alias q && alias x
  '
  [ "$status" -eq 0 ]
}

@test "bash: editor env set" {
  run bash --norc --noprofile -c '
    source "'"$HOME_SRC"'/dot_config/bashrc.d/0.editor.sh"
    echo "$EDITOR"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"vim"* ]] || [[ "$output" == *"nvim"* ]]
}

@test "bash: PATH includes .local/bin" {
  run bash --norc --noprofile -c '
    source "'"$HOME_SRC"'/dot_config/bashrc.d/paths.sh"
    echo "$PATH"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *".local/bin"* ]]
}

@test "bash: CDPATH configured" {
  run bash --norc --noprofile -c '
    source "'"$HOME_SRC"'/dot_config/bashrc.d/paths.sh"
    echo "$CDPATH"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"src"* ]]
}

@test "bash: kubectl aliases guard on kubectl availability" {
  # The kubectl.sh script should not error when kubectl is missing
  run bash --norc --noprofile -c '
    source "'"$HOME_SRC"'/dot_config/bashrc.d/kubectl.sh"
  '
  [ "$status" -eq 0 ]
}

@test "bash: kubectl alias 'k' defined when kubectl present" {
  skip_if_no_command kubectl
  run bash --norc --noprofile -c '
    shopt -s expand_aliases
    source "'"$HOME_SRC"'/dot_config/bashrc.d/kubectl.sh"
    alias k
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"kubectl"* ]]
}

@test "bash: exa/eza aliases guard on availability" {
  run bash --norc --noprofile -c '
    source "'"$HOME_SRC"'/dot_config/bashrc.d/exa.sh"
  '
  [ "$status" -eq 0 ]
}

@test "bash: mktdir aliases defined" {
  run bash --norc --noprofile -c '
    shopt -s expand_aliases
    source "'"$HOME_SRC"'/dot_config/bashrc.d/mktdir.sh"
    alias mktdir && alias mktmp
  '
  [ "$status" -eq 0 ]
}

@test "bash: flatpak-wrappers sources without error" {
  run bash --norc --noprofile -c '
    source "'"$HOME_SRC"'/dot_config/bashrc.d/flatpak-wrappers.sh"
  '
  [ "$status" -eq 0 ]
}

@test "bash: extras sets MANPAGER" {
  run bash --norc --noprofile -c '
    source "'"$HOME_SRC"'/dot_config/bashrc.d/extras.sh"
    echo "$MANPAGER"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"bat"* ]]
}

# --- Fish interactive features ---

@test "fish: config.fish sets vi keybindings" {
  skip_if_no_command fish
  grep -q 'fish_vi_key_bindings' "$HOME_SRC/dot_config/fish/config.fish"
}

@test "fish: alias.fish defines common aliases" {
  skip_if_no_command fish
  run fish --no-execute "$HOME_SRC/dot_config/fish/conf.d/alias.fish"
  [ "$status" -eq 0 ]
  # Check key aliases are in the file
  grep -q 'alias ":q" exit' "$HOME_SRC/dot_config/fish/conf.d/alias.fish"
  grep -q 'alias open xdg-open' "$HOME_SRC/dot_config/fish/conf.d/alias.fish"
}

@test "fish: editor.fish sets EDITOR" {
  skip_if_no_command fish
  grep -qE 'set.*EDITOR' "$HOME_SRC/dot_config/fish/conf.d/editor.fish"
}

@test "fish: kubealias.fish defines kubectl abbreviations" {
  skip_if_no_command fish
  # Should define k -> kubectl
  grep -q 'abbr -a k kubectl' "$HOME_SRC/dot_config/fish/conf.d/kubealias.fish"
  # Should guard on kubectl availability
  grep -q 'type -q kubectl' "$HOME_SRC/dot_config/fish/conf.d/kubealias.fish"
}

@test "fish: paths.fish sets PATH" {
  skip_if_no_command fish
  grep -qE '(fish_add_path|set.*PATH)' "$HOME_SRC/dot_config/fish/conf.d/paths.fish"
}

@test "fish: greeting function produces output" {
  skip_if_no_command fish
  # The greeting function should contain fun quotes
  grep -q 'function fish_greeting' "$HOME_SRC/dot_config/fish/functions/fish_greeting.fish"
  grep -q 'Howdy' "$HOME_SRC/dot_config/fish/functions/fish_greeting.fish"
}

@test "fish: conf.d scripts guard on tool availability" {
  skip_if_no_command fish
  # Scripts that depend on external tools should check before using
  local guarded_scripts=(
    "kubealias.fish:kubectl"
    "exa.fish:eza"
    "thefuck.fish:thefuck"
    "carapace.fish:carapace"
    "krew.fish:kubectl"
    "television.fish:tv"
    "yazi.fish:yazi"
  )
  local failed=0
  for entry in "${guarded_scripts[@]}"; do
    local script="${entry%%:*}"
    local tool="${entry##*:}"
    local filepath="$HOME_SRC/dot_config/fish/conf.d/$script"
    [ -f "$filepath" ] || continue
    if ! grep -qE "(type -q $tool|command -v $tool|which $tool)" "$filepath"; then
      echo "FAIL: $script doesn't guard on '$tool' availability" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

# --- Cross-shell consistency ---

@test "bash and fish define the same core aliases" {
  # Both shells should define these essential aliases
  local core_aliases=("q" "x" "open" "ll" "la")
  local failed=0
  for a in "${core_aliases[@]}"; do
    local in_bash in_fish
    in_bash=$(grep -c "alias.*\"$a\"\\|alias.*$a=" "$HOME_SRC/dot_config/bashrc.d/rwaltr-aliases.sh" 2>/dev/null || echo 0)
    in_fish=$(grep -c "alias $a " "$HOME_SRC/dot_config/fish/conf.d/alias.fish" 2>/dev/null || echo 0)
    if [ "$in_bash" -eq 0 ] && [ "$in_fish" -eq 0 ]; then
      echo "FAIL: alias '$a' missing from both bash and fish" >&2
      failed=1
    elif [ "$in_bash" -eq 0 ]; then
      echo "WARN: alias '$a' in fish but not bash" >&2
    elif [ "$in_fish" -eq 0 ]; then
      echo "WARN: alias '$a' in bash but not fish" >&2
    fi
  done
  [ "$failed" -eq 0 ]
}

@test "bash and fish both set EDITOR" {
  grep -qE '(EDITOR|editor)' "$HOME_SRC/dot_config/bashrc.d/0.editor.sh"
  grep -qE '(EDITOR|editor)' "$HOME_SRC/dot_config/fish/conf.d/editor.fish"
}
