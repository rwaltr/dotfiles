# television — fuzzy finder shell integration
# shellcheck shell=bash
if command -v tv &>/dev/null; then
	eval "$(tv init bash)"
fi
