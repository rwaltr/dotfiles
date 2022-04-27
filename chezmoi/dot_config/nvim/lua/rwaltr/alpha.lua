local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[ _______                        __   __              ]],
	[[|       \                      |  \ |  \             ]],
	[[| ▓▓▓▓▓▓▓\__   __   __  ______ | ▓▓_| ▓▓_    ______  ]],
	[[| ▓▓__| ▓▓  \ |  \ |  \|      \| ▓▓   ▓▓ \  /      \ ]],
	[[| ▓▓    ▓▓ ▓▓ | ▓▓ | ▓▓ \▓▓▓▓▓▓\ ▓▓\▓▓▓▓▓▓ |  ▓▓▓▓▓▓\]],
	[[| ▓▓▓▓▓▓▓\ ▓▓ | ▓▓ | ▓▓/      ▓▓ ▓▓ | ▓▓ __| ▓▓   \▓▓]],
	[[| ▓▓  | ▓▓ ▓▓_/ ▓▓_/ ▓▓  ▓▓▓▓▓▓▓ ▓▓ | ▓▓|  \ ▓▓      ]],
	[[| ▓▓  | ▓▓\▓▓   ▓▓   ▓▓\▓▓    ▓▓ ▓▓  \▓▓  ▓▓ ▓▓      ]],
	[[ \▓▓   \▓▓ \▓▓▓▓▓\▓▓▓▓  \▓▓▓▓▓▓▓\▓▓   \▓▓▓▓ \▓▓      ]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("n", "  New note", ":lua require('telekasten').new_templated_note()<CR>"),
	dashboard.button("N", "  Search Notes", ":lua require('telekasten').find_notes()<CR>"),
	dashboard.button("d", "ﴬ  Open Today's Note", ":lua require('telekasten').goto_today()<CR>"),
	dashboard.button("w", "ﴬ  Open Week's Note", ":lua require('telekasten').goto_thisweek()<CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.local/share/chezmoi/home/dot_config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
	-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
	return "rwaltr"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
