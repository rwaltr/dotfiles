# Nvim
if [ -x "$(command -v nvim)" ]; then
  alias vim=nvim
  alias vi=vim
  export EDITOR=nvim
else
  alias vi=vim
  export EDITOR=vim
fi
