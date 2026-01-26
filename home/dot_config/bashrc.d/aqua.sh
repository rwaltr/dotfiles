# Aqua package manager configuration
if command -v aqua &>/dev/null; then
	export AQUA_CONFIG="$HOME/.config/aqua/aqua.yaml"
	export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
	export AQUA_ROOT_DIR="$HOME/.local/share/aqua"
	export PATH="$AQUA_ROOT_DIR/bin:$PATH"
fi
