require("neorg").setup({
	-- Tell Neorg what modules to load
	load = {
		["core.defaults"] = {}, -- Load all the default modules
		["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<Leader>o"
      }
    }, -- Load all the default modules
		["core.norg.concealer"] = {}, -- Allows for use of icons
		["core.norg.dirman"] = { -- Manage your directories with Neorg
			config = {
				workspaces = {
					rwaltr = "~/Documents/neorg",
				},
			},
		},
		["core.norg.completion"] = {
    config = {
        engine = "nvim-cmp" -- We current support nvim-compe and nvim-cmp only
    }
},
                ["core.integrations.telescope"] = {}, -- Enable the telescope module
		["core.norg.journal"] = {},
	},
})


local neorg_callbacks = require("neorg.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
            { "<C-s>", "core.integrations.telescope.find_linkable" },
        },

        i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
        },
    }, {
        silent = true,
        noremap = true,
    })
end)
