-- Treesitter
require'nvim-treesitter.configs'.setup{
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {"yaml"},
	},
	ensure_installed = "maintained",
}
