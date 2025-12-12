# Editor configuration
if command -v nvim &> /dev/null; then
    export EDITOR=nvim
    export KUBE_EDITOR=$EDITOR
    alias nv=nvim
    alias nano=nvim
fi
