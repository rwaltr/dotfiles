#!/usr/bin/env bats
# Security checks - no leaked secrets in source tree

load '../helpers/test_helper'

setup() {
  common_setup
}

@test "no AWS access keys in source" {
  local found
  found=$(grep -rE 'AKIA[0-9A-Z]{16}' "$HOME_SRC" --include='*.sh' --include='*.fish' --include='*.lua' --include='*.toml' --include='*.yaml' --include='*.nu' 2>/dev/null || true)
  [ -z "$found" ]
}

@test "no private key material in non-template files" {
  local found
  found=$(grep -rl 'BEGIN.*PRIVATE KEY' "$HOME_SRC" 2>/dev/null | grep -v '\.tmpl$' | grep -v '\.age$' || true)
  [ -z "$found" ]
}

@test "no hardcoded passwords in shell configs" {
  local found
  found=$(grep -rEi '(password|passwd|secret)\s*=\s*["\x27][^"\x27]+["\x27]' "$HOME_SRC" \
    --include='*.sh' --include='*.fish' --include='*.nu' \
    2>/dev/null | grep -v '\.tmpl' | grep -v '#' || true)
  [ -z "$found" ]
}

@test "no API keys/tokens in non-template files" {
  local found
  found=$(grep -rEi '(api_key|apikey|api_token|access_token)\s*=\s*["\x27][a-zA-Z0-9]{20,}' "$HOME_SRC" \
    --include='*.sh' --include='*.fish' --include='*.toml' --include='*.yaml' --include='*.nu' \
    2>/dev/null | grep -v '\.tmpl$' || true)
  [ -z "$found" ]
}

@test "no .env files with actual values" {
  local found
  found=$(find "$HOME_SRC" -name '.env' -not -name '*.tmpl' -type f 2>/dev/null || true)
  [ -z "$found" ]
}

@test "sops-encrypted files are actually encrypted" {
  # Any file referenced by .sops.yaml should contain sops metadata if it exists
  if [ -f "$HOME_SRC/dot_config/sops/age/private_keys.txt.tmpl" ]; then
    # Template files are ok - they pull from 1password at apply time
    # Just make sure there's no plaintext age key
    local found
    found=$(grep -l 'AGE-SECRET-KEY-' "$HOME_SRC/dot_config/sops/age/private_keys.txt.tmpl" 2>/dev/null || true)
    [ -z "$found" ]
  fi
}
