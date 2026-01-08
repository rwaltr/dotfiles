# Homebrew - OS-specific paths
case "$(uname -s)" in
    Darwin)
        # macOS - Apple Silicon
        if [ -f /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        # macOS - Intel
        elif [ -f /usr/local/bin/brew ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        ;;
    Linux)
        # Linuxbrew
        if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
        ;;
esac

# Mise activation
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

# Path configuration
path=(~/.local/bin $path)
export PATH
