-- Autocompletion

local cmp = require("cmp")

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end


local check_backspace = function()
	local col = vim.fn.col(".") - 1
---@diagnostic disable-next-line: param-type-mismatch, undefined-field
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = require("rwaltr.util.icons").kind

--   פּ ﯟ   some other good icons
--[[ local kind_icons = { ]]
--[[ 	Text = "", ]]
--[[ 	Method = "m", ]]
--[[ 	Function = "", ]]
--[[ 	Constructor = "", ]]
--[[ 	Field = "", ]]
--[[ 	Variable = "", ]]
--[[ 	Class = "", ]]
--[[ 	Interface = "", ]]
--[[ 	Module = "", ]]
--[[ 	Property = "", ]]
--[[ 	Unit = "", ]]
--[[ 	Value = "", ]]
--[[ 	Enum = "", ]]
--[[ 	Keyword = "", ]]
--[[ 	Snippet = "", ]]
--[[ 	Color = "", ]]
--[[ 	File = "", ]]
--[[ 	Reference = "", ]]
--[[ 	Folder = "", ]]
--[[ 	EnumMember = "", ]]
--[[ 	Constant = "", ]]
--[[ 	Struct = "", ]]
--[[ 	Event = "", ]]
--[[ 	Operator = "", ]]
--[[ 	TypeParameter = "", ]]
--[[ } ]]

-- find more here: https://www.nerdfonts.com/cheat-sheet
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
		end,
	},
	mapping = cmp.mapping.preset.insert{
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
			vim_item.menu = ({
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
				spell = "[Spelling]",
				nvim_lsp = "[LSP]",
				cmdline = "[CMD]",
				emoji = "[Emoji]",
				calc = "[Calc]",
				nvim_lua = "[NvimLua]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = "nvim_lua" },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "path" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "calc" },
		{ name = "emoji" },
		{ name = "spell" },
	}),
})
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
