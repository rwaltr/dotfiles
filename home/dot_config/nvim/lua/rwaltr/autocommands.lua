vim.cmd([[
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end
  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end
]])

vim.cmd([[
 augroup end
 augroup _chezmoi
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/* | !chezmoi apply --source-path "%" 
 augroup end
]])


