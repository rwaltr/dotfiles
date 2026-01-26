# Temp directory aliases
# shellcheck shell=bash
alias mktmp=mktemp
alias mktdir="mktemp -d"

# cdtdir - cd to a new temp directory
cdtdir() {
	cd "$(mktemp -d)" || return
}
