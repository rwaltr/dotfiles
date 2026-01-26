# Format man pages
# shellcheck shell=bash
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Backup function
backup() {
	cp "$1" "$1.bak"
}
