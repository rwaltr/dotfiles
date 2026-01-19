-- Default config for wezterm
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- ============================================================================
-- Base Configuration (Common across all platforms)
-- ============================================================================

-- Color scheme
config.color_scheme = "Catppuccin Mocha"

-- Font settings
config.font = wezterm.font_with_fallback({
	{ family = "IosevkaTerm Nerd Font" },
	{ family = "Iosevka Term Font" },
	{ family = "0xProto Nerd Font" },
	{ family = "0xProto" },
	-- "Hack",
	-- "Miracraft",
})
config.window_frame = {
	font = wezterm.font_with_fallback({
		{ family = "Iosevka Term Bold" },
		{ family = "0xProto" },
	}),
	font_size = 8,
}
config.font_size = 10.5
config.inactive_pane_hsb = {
	saturation = 0.5,
	brightness = 0.4,
}

config.keys = {}

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(pane:get_domain_name() .. ":" .. window:active_workspace() .. " ")
end)

-- ============================================================================
-- Platform-Specific Configuration (Load Early for fd_path)
-- ============================================================================

-- Detect the platform using target_triple
-- See: https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html
local platform_module = nil
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- Windows
	platform_module = require("platforms.windows")
elseif wezterm.target_triple:find("darwin") then
	-- macOS (Intel or Apple Silicon)
	platform_module = require("platforms.macos")
elseif wezterm.target_triple:find("linux") then
	-- Linux
	platform_module = require("platforms.linux")
end

-- ============================================================================
-- Session managment
-- ============================================================================

local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
local history = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer-history")
-- local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
-- resurrect.state_manager.periodic_save({
-- 	interval_seconds = 15 * 60,
-- 	save_workspaces = true,
-- 	save_windows = true,
-- 	save_tabs = true,
-- })
--
-- -- Oh god help lol
-- wezterm.on("resurrect.error", function(err)
-- 	wezterm.log_error("ERROR!")
-- 	wezterm.gui.gui_windows()[1]:toast_notification("resurrect", err, nil, 3000)
-- end)

-- Build FdSearch options with platform-specific fd_path if available
local fd_search_opts = { wezterm.home_dir .. "/src" }
if platform_module and platform_module.fd_path then
	fd_search_opts.fd_path = platform_module.fd_path
end

local schema = {
	options = { callback = history.Wrapper(sessionizer.DefaultCallback) },
	history.MostRecentWorkspace({}),
	sessionizer.DefaultWorkspace({}),
	wezterm.home_dir .. "/Documents/Notebook",
	wezterm.home_dir .. "/.local/share/chezmoi",
	wezterm.home_dir .. "/src",
	sessionizer.FdSearch(fd_search_opts),

	processing = sessionizer.for_each_entry(function(entry)
		entry.label = entry.label:gsub(wezterm.home_dir, "~")
	end),
}

table.insert(config.keys, {
	key = "s",
	mods = "ALT",
	action = sessionizer.show(schema),
})
table.insert(config.keys, {
	key = "m",
	mods = "ALT",
	action = history.switch_to_most_recent_workspace,
})
table.insert(config.keys, {
	key = "u",
	mods = "ALT",
	action = wezterm.action.AttachDomain("unix"),
})
table.insert(config.keys, {
	key = "u",
	mods = "ALT|CTRL",
	action = wezterm.action.DetachDomain({ DomainName = "unix" }),
})

-- Domain Managment
local domains = wezterm.plugin.require("https://github.com/DavidRR-F/quick_domains.wezterm")
domains.apply_to_config(config)

-- Splts
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "ALT",
	},
})

-- ============================================================================
-- Apply Platform-Specific Configuration
-- ============================================================================

-- Platform module was loaded earlier for fd_path, now apply config
if platform_module then
	platform_module.apply_to_config(config)
end

-- ============================================================================
-- Local Machine-Specific Overrides (Optional)
-- ============================================================================

-- Attempt to load local.lua for machine-specific overrides
-- This file is optional and should be in .chezmoiignore
local has_local, local_module = pcall(require, "local")
if has_local and local_module and local_module.apply_to_config then
	local_module.apply_to_config(config)
end

-- and finally, return the configuration to wezterm
return config
