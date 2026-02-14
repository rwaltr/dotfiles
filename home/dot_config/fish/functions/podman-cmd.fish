# podman-cmd — run a container image as if it were a local command
#
# Usage:
#   podman-cmd <image> [args...]
#
# Mounts the current directory and home, preserves UID/GID, uses host network.
# SSH_AUTH_SOCK is forwarded if set.
#
# Example — use as a wrapper:
#   function resticprofile
#       podman-cmd ghcr.io/creativeprojects/resticprofile:latest $argv
#   end

function podman-cmd
    if test (count $argv) -lt 1
        echo "Usage: podman-cmd <image> [args...]"
        return 1
    end

    set image $argv[1]
    set args $argv[2..]

    set volume_flags \
        --volume "$HOME:$HOME" \
        --volume (pwd):(pwd)

    set env_flags \
        --env HOME="$HOME" \
        --env USER="$USER"

    # Forward SSH agent if available
    if set -q SSH_AUTH_SOCK
        set volume_flags $volume_flags --volume "$SSH_AUTH_SOCK:$SSH_AUTH_SOCK"
        set env_flags $env_flags --env SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
    end

    # Use -t only when stdout is a terminal
    set tty_flag
    if isatty stdout
        set tty_flag -t
    end

    podman run --rm -i $tty_flag \
        --network=host \
        --userns=keep-id \
        --workdir (pwd) \
        $volume_flags \
        $env_flags \
        $image \
        $args
end
