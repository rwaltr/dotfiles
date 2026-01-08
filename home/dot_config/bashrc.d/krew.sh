# Krew kubectl plugin manager
if command -v kubectl &> /dev/null; then
    export KREW_ROOT="$HOME/.local/share/krew"
    export PATH="$KREW_ROOT/bin:$PATH"
fi
