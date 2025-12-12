# Krew kubectl plugin manager
if command -v kubectl &> /dev/null; then
    export KREW_ROOT="$HOME/.local/share/krew"
    path=("$KREW_ROOT/bin" $path)
    export PATH
fi
