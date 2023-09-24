--#region git
local gitgroup = vim.api.nvim_create_augroup("_git", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "gitcommit",
	callback = function()
		vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
		vim.api.nvim_set_option_value("spell", true, { scope = "local" })
	end,
	group = gitgroup,
})
--#endregion git

--#region chezmoi
local chezmoigroup = vim.api.nvim_create_augroup("_chezmoi", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "**/.local/share/chezmoi/home/dot_config/nvim/**",
	callback = function()
		local job = require("plenary.job")
		job:new({
      -- TODO: a better notification
			command = "chezmoi",
			args = { "apply", "--source-path", vim.api.nvim_buf_get_name(0) },
			on_start = function()
				vim.notify("Writing for" .. vim.api.nvim_buf_get_name(0))
			end,
			on_exit = function()
				vim.notify("Chezmoi Complete")
			end,
		}):start()
	end,
	group = chezmoigroup,
})
--#endregion chezmoi
-- TODO: This should be better handled by ftdetect folders
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
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})
--#endregion TextYankin

--#region Yaml
local yamlgroup = vim.api.nvim_create_augroup("_yaml", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "yaml",
	group = yamlgroup,
	callback = function()
		vim.api.nvim_set_option_value("ts", 2, { scope = "local" })
		vim.api.nvim_set_option_value("sts", 2, { scope = "local" })
		vim.api.nvim_set_option_value("sw", 2, { scope = "local" })
		vim.api.nvim_set_option_value("expandtab", true, { scope = "local" })
	end,
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
