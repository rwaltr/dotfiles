local schemastoresSchemas = require("schemastore").json.schemas()
--
local opts = {
	settings = {
		json = {
			schemas = vim.list_extend({ default_schemas }, { schemastoresSchemas }),
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	},
}

return opts
