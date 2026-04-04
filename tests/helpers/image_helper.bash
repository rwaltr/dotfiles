#!/usr/bin/env bash
# Image test helper - podman lifecycle and goss wrappers

# Resolve tool paths via mise
GOSS_BIN="$(mise which goss 2>/dev/null)"

# Test directories
IMAGE_TEST_DIR="${PROJECT_ROOT}/tests/image"
PREREQS_DIR="${IMAGE_TEST_DIR}/prereqs"
GOSS_DIR="${IMAGE_TEST_DIR}/goss"
APPLY_SCRIPT="${IMAGE_TEST_DIR}/apply.sh"

# Persistent state dir for container names across tests
IMAGE_STATE_DIR="${BATS_SUITE_TMPDIR:-/tmp/dotfiles-test-$$}"
mkdir -p "$IMAGE_STATE_DIR"

# Get image ref for a target name
get_image() {
  case "$1" in
    bootc-zirconium) echo "ghcr.io/zirconium-dev/zirconium:latest" ;;
    bluefin)         echo "ghcr.io/ublue-os/bluefin:stable" ;;
    *) echo "ERROR: unknown target $1" >&2; return 1 ;;
  esac
}

# Get list of all targets
get_targets() {
  if [ -n "${TEST_TARGET:-}" ]; then
    echo "$TEST_TARGET"
  else
    echo "bootc-zirconium"
    echo "bluefin"
  fi
}

# Run a command inside an image via podman
# Usage: run_in_image <image> <command>
run_in_image() {
  local image="$1"
  shift
  podman run --rm \
    --volume "${PROJECT_ROOT}:/dotfiles:ro" \
    --env TERM=dumb \
    "$image" \
    bash -c "$*"
}

# Run apply.sh inside an image, persist container for subsequent tests
# Usage: apply_in_image <target_name>
# Container name stored in IMAGE_STATE_DIR for retrieval by get_container()
apply_in_image() {
  local target="$1"
  local image
  image="$(get_image "$target")"
  local container_name="dotfiles-test-${target}-$$"

  # Remove any stale container from a previous run
  podman rm -f "$container_name" &>/dev/null || true

  # Create container with source mounted
  # Runs as root initially so apply.sh can create the test user
  podman create \
    --name "$container_name" \
    --volume "${PROJECT_ROOT}:/dotfiles:ro" \
    --env TERM=dumb \
    "$image" \
    sleep infinity >/dev/null 2>&1

  # Start it
  podman start "$container_name" >/dev/null 2>&1

  # Store container name for other tests to retrieve
  echo "$container_name" > "${IMAGE_STATE_DIR}/container-${target}"

  # Copy apply script in and run it
  podman cp "$APPLY_SCRIPT" "${container_name}:/tmp/apply.sh"
  podman exec "$container_name" bash /tmp/apply.sh
}

# Get the container name for a target (set by apply_in_image)
get_container() {
  local target="$1"
  local state_file="${IMAGE_STATE_DIR}/container-${target}"
  if [ -f "$state_file" ]; then
    cat "$state_file"
  else
    return 1
  fi
}

# Run goss validation inside a running container
# Usage: run_goss <container_name> <goss_file> [<goss_file2> ...]
run_goss() {
  local container="$1"
  shift

  # Copy goss binary into container
  podman cp "$GOSS_BIN" "${container}:/tmp/goss"
  podman exec "$container" chmod +x /tmp/goss

  # Merge goss files and copy in
  local merged
  merged=$(mktemp)
  # Start with empty goss structure
  echo '---' > "$merged"

  for gf in "$@"; do
    if [ -f "$gf" ]; then
      podman cp "$gf" "${container}:/tmp/$(basename "$gf")"
    fi
  done

  # Run goss with each file
  local status=0
  for gf in "$@"; do
    if [ -f "$gf" ]; then
      local basename
      basename="$(basename "$gf")"
      if ! podman exec "$container" /tmp/goss --gossfile "/tmp/${basename}" validate; then
        status=1
      fi
    fi
  done

  rm -f "$merged"
  return "$status"
}

# Run prereq checks against an image using podman
# Usage: validate_prereqs <image> <commands...>
# Each command arg is run inside the image and must exit 0
validate_prereqs() {
  local image="$1"
  shift
  local failed=0
  for check in "$@"; do
    if ! podman run --rm "$image" sh -c "$check" &>/dev/null; then
      echo "PREREQ FAIL: $check" >&2
      failed=1
    fi
  done
  [ "$failed" -eq 0 ]
}

# Cleanup a test container
cleanup_container() {
  local container="$1"
  podman rm -f "$container" &>/dev/null || true
}
