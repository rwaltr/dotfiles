" Rwaltr Nvim config

" General Settings
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/mappings.vim

" The great Luaing
lua << EOF
require('plugins')
require('plugins_options')
EOF
