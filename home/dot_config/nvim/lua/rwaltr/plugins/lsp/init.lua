local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("rwaltr.plugins.lsp.mason")
require("rwaltr.plugins.lsp.handlers").setup()
require("rwaltr.plugins.lsp.null-ls")
