# podman-cmd — run a container image as if it were a local command
#
# Usage:
#   podman-cmd <image> [args...]
#
# Mounts the current directory and home, preserves UID/GID, uses host network.
# SSH_AUTH_SOCK is forwarded if set.
#
# Example — use as a wrapper:
#   resticprofile() { podman-cmd ghcr.io/creativeprojects/resticprofile:latest "$@"; }

podman-cmd() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: podman-cmd <image> [args...]" >&2
        return 1
    fi

    local image="$1"
    shift

    local -a volume_flags=(
        --volume "${HOME}:${HOME}"
        --volume "$(pwd):$(pwd)"
    )

    local -a env_flags=(
        --env HOME="${HOME}"
        --env USER="${USER}"
    )

    # Forward SSH agent if available
    if [[ -n "${SSH_AUTH_SOCK:-}" ]]; then
        volume_flags+=(--volume "${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK}")
        env_flags+=(--env SSH_AUTH_SOCK="${SSH_AUTH_SOCK}")
    fi

    # Use -t only when stdout is a terminal
    local tty_flag=""
    [[ -t 1 ]] && tty_flag="-t"

    podman run --rm -i ${tty_flag} \
        --network=host \
        --userns=keep-id \
        --workdir "$(pwd)" \
        "${volume_flags[@]}" \
        "${env_flags[@]}" \
        "${image}" \
        "$@"
}
