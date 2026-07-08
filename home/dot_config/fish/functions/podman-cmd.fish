# podman-cmd shim — delegates to the shared standalone helper.
# Shared binary: ~/.local/bin/podman-cmd

function podman-cmd
    command podman-cmd $argv
end
