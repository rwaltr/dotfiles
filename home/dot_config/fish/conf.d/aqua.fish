if type -q aqua
 set -gx AQUA_CONFIG $HOME/.config/aqua/aqua.yaml
 set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aqua/aqua.yaml
 set -gx AQUA_ROOT_DIR $HOME/.local/share/aqua
 fish_add_path $AQUA_ROOT_DIR/bin
end
