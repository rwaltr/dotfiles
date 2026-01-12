-- macOS-specific configuration for WezTerm
-- This module exports an apply_to_config function that modifies the config table

local wezterm = require("wezterm")
local module = {}

-- Helper function to find fd binary on macOS
-- Checks common Homebrew installation paths using simple file existence checks
local function find_fd_binary()
	-- Try common Homebrew paths (Apple Silicon first, then Intel)
	local paths = {
		"/opt/homebrew/bin/fd", -- Apple Silicon Homebrew
		"/usr/local/bin/fd", -- Intel Homebrew
	}

	-- Check if file exists and is executable
	for _, path in ipairs(paths) do
		local f = io.open(path, "r")
		if f then
			f:close()
			return path
		end
	end

	-- If not found in common locations, return nil and let fd be searched in PATH
	return nil
end

-- Export fd_path for use in sessionizer configuration
module.fd_path = find_fd_binary()

function module.apply_to_config(config)
	-- macOS-specific font rendering
	-- Retina displays typically look better with slightly larger fonts
	-- Uncomment and adjust as needed:
	-- config.font_size = 14

	-- Use native macOS fullscreen mode
	config.native_macos_fullscreen_mode = false

	-- macOS-specific window decorations
	-- config.window_decorations = "RESIZE"

	-- Enable the fancy (native-looking) tab bar on macOS
	config.use_fancy_tab_bar = true
	config.window_decorations = "RESIZE | INTEGRATED_BUTTONS"

	-- Configure the fancy tab bar appearance
	config.window_frame = {
		-- The font used in the tab bar
		font = wezterm.font({ family = "Roboto", weight = "Bold" }),
		-- The size of the font in the tab bar
		font_size = 12.0,
		-- The overall background color of the tab bar when the window is focused
		active_titlebar_bg = "#333333",
		-- The overall background color of the tab bar when the window is not focused
		inactive_titlebar_bg = "#333333",
	}

	-- macOS-specific key bindings could go here
	-- config.keys = config.keys or {}
	-- table.insert(config.keys, {
	--   key = 'k',
	--   mods = 'CMD',
	--   action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
	-- })
end

return module
