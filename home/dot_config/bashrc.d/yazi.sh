# yazi — terminal file manager with directory changing on exit
# shellcheck shell=bash
if command -v yazi &>/dev/null; then
	function y() {
		local tmp
		tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
		yazi "$@" --cwd-file="$tmp"
		if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
			builtin cd -- "$cwd" || return
		fi
		rm -f -- "$tmp"
	}
fi
