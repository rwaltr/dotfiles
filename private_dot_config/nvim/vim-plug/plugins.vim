" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
		Plug 'ryanoasis/vim-devicons'
    " Auto pairs for '(' '[' '{' 
    Plug 'jiangmiao/auto-pairs'
		"Chezmoi Integration
		Plug 'Lilja/vim-chezmoi'
		"Vimwiki
		Plug 'vimwiki/vimwiki'
		" FZF
		"Plug 'junegunn/fzf.vim'
		" Ansible-vim
		Plug 'pearofducks/ansible-vim'
		" Wich Vim
		Plug 'liuchengxu/vim-which-key'
		" Color preview
		Plug 'https://github.com/ap/vim-css-color'
		" Git Integration
		Plug 'mhinz/vim-signify'
		Plug 'tpope/vim-fugitive'
		Plug 'tpope/vim-rhubarb'
		Plug 'junegunn/gv.vim'
		Plug 'christoomey/vim-tmux-navigator'
		Plug 'arcticicestudio/nord-vim'
		Plug 'scrooloose/nerdcommenter'

		"Plug 'dylanaraps/wal.vim'
		" LSP
		if has("nvim-0.5")
		" TODO
		Plug 'neovim/nvim-lspconfig' 
		" TODO
		Plug 'sbdchd/neoformat'
		" TODO
		Plug 'simrat39/symbols-outline.nvim'
		" TODO
	  Plug 'glepnir/lspsaga.nvim'	
		" TODO
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
		" TODO
		Plug 'nvim-treesitter/playground'
		" TODO
		Plug 'puremourning/vimspector'
		Plug 'folke/lsp-colors.nvim'
		Plug 'williamboman/nvim-lsp-installer'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-telescope/telescope-fzf-native.nvim'
		Plug 'nvim-telescope/telescope.nvim'
		Plug 'nvim-lualine/lualine.nvim'
		Plug 'kyazdani42/nvim-web-devicons'
		Plug 'hrsh7th/cmp-nvim-lsp'
		Plug 'hrsh7th/cmp-buffer'
		Plug 'hrsh7th/cmp-path'
		Plug 'hrsh7th/cmp-cmdline'
		Plug 'hrsh7th/nvim-cmp'
	  else
			
		" LSP
		endif
call plug#end()
