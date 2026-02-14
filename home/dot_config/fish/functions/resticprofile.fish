# resticprofile — run resticprofile via podman-cmd
function resticprofile
    podman-cmd ghcr.io/creativeprojects/resticprofile:latest $argv
end
