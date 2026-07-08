# podman-cmd shim — delegates to the shared standalone helper.
# Shared binary: ~/.local/bin/podman-cmd

podman-cmd() {
    command podman-cmd "$@"
}
