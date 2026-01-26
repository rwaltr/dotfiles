# Carapace completion configuration
# shellcheck shell=bash
# shellcheck disable=SC1090
if command -v carapace &>/dev/null; then
	export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
	source <(carapace _carapace)
fi
