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

if vim.fn.has("nvim-0.7") == 0 then
	return
end

--#region git
local gitgroup = vim.api.nvim_create_augroup("_git", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "gitcommit",
	callback = function()
		vim.api.nvim_set_option_value("wrap", "true", "local")
		vim.api.nvim_set_option_value("spell", "true", "local")
	end,
	group = gitgroup,
})
--#endregion git

--#region chezmoi
local chezmoigroup = vim.api.nvim_create_augroup("_chezmoi", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "~/.local/share/chezmoi/*",
	callback = function()
    vim.cmd("silent! chezmoi apply --source-path %")
  end,
	group = chezmoigroup,
})
--#endregion chezmoi

--#region TextYankin
vim.api.nvim_create_autocmd({"TextYankPost"}, {
  callback = function() vim.highlight.on_yank({higroup = 'Visual', timeout = 200}) end,
})
--#endregion TextYankin
