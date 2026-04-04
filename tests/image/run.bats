#!/usr/bin/env bats
# Image-based integration tests
# Runs dotfiles apply inside real OS container images and validates with goss
#
# Usage:
#   bats tests/image/run.bats                              # all targets
#   TEST_TARGET=bootc-zirconium bats tests/image/run.bats  # single target

load '../helpers/test_helper'
load '../helpers/image_helper'

setup() {
  common_setup
  skip_if_no_command podman
}

# Helper: skip if not targeting this image
should_run() {
  if [ -n "${TEST_TARGET:-}" ] && [ "$TEST_TARGET" != "$1" ]; then
    skip "filtered out (TEST_TARGET=$TEST_TARGET)"
  fi
}

# --- bootc-zirconium ---

@test "bootc-zirconium: prereqs pass" {
  should_run bootc-zirconium
  validate_prereqs "$(get_image bootc-zirconium)" \
    "bash --version" \
    "curl --version" \
    "git --version" \
    "chezmoi --version" \
    "rpm --version" \
    "grep -q 'ID=fedora' /etc/os-release"
}

@test "bootc-zirconium: chezmoi apply succeeds" {
  should_run bootc-zirconium
  apply_in_image bootc-zirconium
}

@test "bootc-zirconium: goss common validation" {
  should_run bootc-zirconium
  local container
  container=$(get_container bootc-zirconium) || skip "apply did not run"
  run_goss "$container" "$GOSS_DIR/common.yaml"
}

@test "bootc-zirconium: goss target-specific validation" {
  should_run bootc-zirconium
  local container
  container=$(get_container bootc-zirconium) || skip "apply did not run"
  run_goss "$container" "$GOSS_DIR/bootc-zirconium.yaml"
}

@test "bootc-zirconium: scripts + idempotency" {
  should_run bootc-zirconium
  local container
  container=$(get_container bootc-zirconium) || skip "apply did not run"
  run_goss "$container" "$GOSS_DIR/scripts.yaml"
}

# --- bluefin ---

@test "bluefin: prereqs pass" {
  should_run bluefin
  validate_prereqs "$(get_image bluefin)" \
    "bash --version" \
    "curl --version" \
    "git --version" \
    "fish --version" \
    "dnf --version" \
    "grep -q 'ID=bluefin' /etc/os-release"
}

@test "bluefin: chezmoi apply succeeds" {
  should_run bluefin
  apply_in_image bluefin
}

@test "bluefin: goss common validation" {
  should_run bluefin
  local container
  container=$(get_container bluefin) || skip "apply did not run"
  run_goss "$container" "$GOSS_DIR/common.yaml"
}

@test "bluefin: goss target-specific validation" {
  should_run bluefin
  local container
  container=$(get_container bluefin) || skip "apply did not run"
  run_goss "$container" "$GOSS_DIR/bluefin.yaml"
}

@test "bluefin: scripts + idempotency" {
  should_run bluefin
  local container
  container=$(get_container bluefin) || skip "apply did not run"
  run_goss "$container" "$GOSS_DIR/scripts.yaml"
}

# --- cleanup ---

teardown_file() {
  for target in bootc-zirconium bluefin; do
    local container
    container=$(get_container "$target" 2>/dev/null) || continue
    cleanup_container "$container"
  done
}
