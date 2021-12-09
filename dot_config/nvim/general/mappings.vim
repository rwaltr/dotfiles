" Rwaltr Nvim Mappings
" TODO: Convert to Lua

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-Q> <C-W><C-Q>
nnoremap <C-W>t :tabnew<CR>
nnoremap <C-W><C-t> :tabnew<CR>

"Clear search highlights
nnoremap <C-c> :nohlsearch<CR>

"Remap window splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"" Nerdfree
nnoremap <leader>n :NvimTreeFocus<CR>
nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <C-f> :NvimTreeFind<CR>


" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

