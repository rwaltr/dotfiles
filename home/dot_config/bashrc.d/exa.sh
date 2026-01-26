# Modern ls replacements
# shellcheck shell=bash
if command -v eza &>/dev/null; then
	alias ls=eza
elif command -v lsd &>/dev/null; then
	alias ls=lsd
fi
