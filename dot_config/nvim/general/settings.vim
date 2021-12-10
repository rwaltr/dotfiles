" Rwaltr Nvim Settings
" TODO: Convert to Lua
set number					" show numbers
set nowrap					" No line wrapping
set mouse=a					" Auto Mouse support
set ruler						" Show Cusor all the time
set iskeyword+=-		" Add - to words
set tabstop=2 softtabstop=2	" 2 spaces for tab
set shiftwidth=2		" 2 spaces per indent
set smarttab				" Smart tab detection
set autoindent			" Good auto indent
set cursorline			" Highlight current line
"set noshowmode			" Doest show current mode
set splitbelow			" Splits downards
set splitright			" Splits right
set nocompatible		" Doesnt try to be old vim
set relativenumber	" Show relativenumber
set mouse=nv				" Allow Mouse in Normal and Visual mode
filetype plugin on  " Filesystem
syntax on						" Syntax Highlighting
set ignorecase			" Ignoes case on searching
set smartcase				" enable case sensitive when search contains case
set incsearch				" go to next search
set scrolloff=12				" starts scrolling before it hits the bottom or top of page

" spell checking
"set complete+=kspell
"set completeopt=menuone,longest

" Add Global Clipboard only if supported
if has ('unnamedplus')
	set clipboard=unnamedplus
endif

let g:chezmoi = "enabled" "engage Chezmoi Plug


" Vimwiki settings
let g:vimwiki_list = [{'path': '~/Documents/VimWiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let gvimwiki_markdown_link_ext=1

let g:taskwiki_markdown_syntax = 'markdown'
let g:markdown_folding = 1

set termguicolors
colorscheme lushwal

" Git related settings

" Change these if you want
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
set updatetime=100
" I find the numbers disctracting
let g:signify_sign_show_count = 1
let g:signify_sign_show_text = 1

" If you like colors instead
" highlight SignifySignAdd                  ctermbg=green                guibg=#00ff00
" highlight SignifySignDelete ctermfg=black ctermbg=red    guifg=#ffffff guibg=#ff0000
" highlight SignifySignChange ctermfg=black ctermbg=yellow guifg=#000000 guibg=#ffff00

au! BufWritePost $MYVIMR source %


" Luatime..
lua << EOF
EOF