-- Windows-specific configuration for WezTerm
-- This module exports an apply_to_config function that modifies the config table

local module = {}

function module.apply_to_config(config)
	-- Windows-specific default shell
	-- Uncomment and adjust based on your preference:
	config.default_prog = { "pwsh.exe" } -- PowerShell 7+
	-- config.default_prog = { "powershell.exe" }  -- Windows PowerShell
	-- config.default_prog = { "cmd.exe" }

	-- Windows Terminal-like behavior
	config.window_decorations = "TITLE | RESIZE"

	-- Better ClearType rendering on Windows
	config.freetype_load_target = "Normal"
	config.freetype_render_target = "Normal"

	-- Windows-specific key bindings could go here
	-- config.keys = config.keys or {}
	-- table.insert(config.keys, {
	--   key = 'v',
	--   mods = 'CTRL',
	--   action = wezterm.action.PasteFrom 'Clipboard',
	-- })
end

return module
