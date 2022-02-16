local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover
null_ls.setup({
	debug = false,
	on_attach = require("rwaltr.lsp.handlers").on_attach,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--jsx-single-quote" } }),
		-- formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.shfmt,
		diagnostics.codespell,
		formatting.codespell,
		diagnostics.shellcheck,
		diagnostics.yamllint,
		diagnostics.proselint,
		code_actions.shellcheck,
		code_actions.gitrebase,
		code_actions.proselint,
		formatting.fish_indent,
		-- hover.dictionary,
		-- diagnostics.flake8
		code_actions.gitsigns,
	},
})
