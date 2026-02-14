# resticprofile — run resticprofile via podman-cmd
resticprofile() {
    podman-cmd ghcr.io/creativeprojects/resticprofile:latest "$@"
}
