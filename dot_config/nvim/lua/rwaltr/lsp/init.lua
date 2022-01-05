local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "rwaltr.lsp.lsp-installer"
require("rwaltr.lsp.handlers").setup()
require "rwaltr.lsp.null-ls"
