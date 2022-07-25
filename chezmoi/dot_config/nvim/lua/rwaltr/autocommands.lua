if vim.fn.has("nvim-0.7") == 0 then

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
]] )

  vim.cmd([[
 augroup end
 augroup _chezmoi
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/* | !chezmoi apply --source-path "%" 
 augroup end
]] )

  return
end

--#region git
local gitgroup = vim.api.nvim_create_augroup("_git", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "gitcommit",
  callback = function()
    vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
    vim.api.nvim_set_option_value("spell", true, { scope = "local" })
  end,
  group = gitgroup
})
--#endregion git

--#region chezmoi
local chezmoigroup = vim.api.nvim_create_augroup("_chezmoi", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "$HOME/.local/share/chezmoi/*",
  callback = function()
  vim.fn.jobstart({"chezmoi", "apply" })
  end,
  group = chezmoigroup,
})
--#endregion chezmoi

--#region svn
local svngroup = vim.api.nvim_create_augroup("_svn", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "svn",
  callback = function()
    vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
    vim.api.nvim_set_option_value("spell", true, { scope = "local" })
  end,
  group = svngroup,
})
--#endregion svn

--#region TextYankin
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function() vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 }) end,
})
--#endregion TextYankin

--#region Yaml
local yamlgroup = vim.api.nvim_create_augroup('_yaml', { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "yaml",
  group = yamlgroup,
  callback = function()
    vim.api.nvim_set_option_value("ts", 2, { scope = "local" })
    vim.api.nvim_set_option_value("sts", 2, { scope = "local" })
    vim.api.nvim_set_option_value("sw", 2, { scope = "local" })
    vim.api.nvim_set_option_value("expandtab", true, { scope = "local" })
  end
})
--#endregion Yaml

--#region markdown
local markdowngroup = vim.api.nvim_create_augroup("_markdown", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
    vim.api.nvim_set_option_value("spell", true, { scope = "local" })
    -- changes ... to the elispis character to make proselint happy, but only in markdown files
    vim.cmd("iab ... …")
  end,
  group = markdowngroup,
})
--#endregion svn
