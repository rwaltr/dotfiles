# Homebrew (Linuxbrew)
# shellcheck shell=bash
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Mise activation
if command -v mise &>/dev/null; then
	eval "$(mise activate bash)"
fi

# PATH configuration
export PATH="$HOME/.local/bin:$PATH"

# CDPATH configuration
export CDPATH=".:~:~/src/rwaltr:~/src/:~/Documents"
