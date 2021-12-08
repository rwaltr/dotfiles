-- Treesitter
require'nvim-treesitter.configs'.setup{
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"bash",
		"dockerfile",
		"go",
		"gomod",
		"json",
		"lua",
		"python",
		"yaml",
		"vim",
		"toml",
	},
}
