-- Nullls
local nullls = require "null-ls"
nullls.config {
sources = {
	nullls.builtins.formatting.prettier,
	}
}

require'lspconfig'["null-ls"].setup{}

