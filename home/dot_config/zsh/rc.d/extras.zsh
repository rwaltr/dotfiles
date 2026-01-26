# Format man pages
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Pi agent configuration
export PI_CODING_AGENT_DIR="$HOME/.config/pi/agent"

# Backup function
backup() {
    cp "$1" "$1.bak"
}
