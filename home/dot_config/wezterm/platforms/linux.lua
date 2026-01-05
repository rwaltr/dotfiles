-- Linux-specific configuration for WezTerm
-- This module exports an apply_to_config function that modifies the config table

local module = {}

function module.apply_to_config(config)
	local wezterm = require("wezterm")

	local function basename(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Enable Wayland if available (recommended for better performance)
	if os.getenv("WAYLANND_DISPLAY") ~= "" then
		config.enable_wayland = true
	end

	-- Linux-specific window decorations
	-- config.window_decorations = "TITLE | RESIZE"

	-- if os.getenv("XDG_CURRENT_DESKTOP") == "niri" then
	-- config.window_padding = {
	-- 	left = 0,
	-- 	right = 0,
	-- 	top = 0,
	-- 	bottom = 0,
	-- }
	-- end

	-- Linux-specific key bindings could go here
	-- config.keys = config.keys or {}
	config.exec_domains = {
		-- Defines a domain called "scoped" that will run the requested
		-- command inside its own individual systemd scope.
		-- This defines a strong boundary for resource control and can
		-- help to avoid OOMs in one pane causing other panes to be
		-- killed.
		wezterm.exec_domain("scoped", function(cmd)
			-- The "cmd" parameter is a SpawnCommand object.
			-- You can log it to see what's inside:
			wezterm.log_info(cmd)

			-- Synthesize a human understandable scope name that is
			-- (reasonably) unique. WEZTERM_PANE is the pane id that
			-- will be used for the newly spawned pane.
			-- WEZTERM_UNIX_SOCKET is associated with the wezterm
			-- process id.
			local env = cmd.set_environment_variables
			local ident = "wezterm-pane-" .. env.WEZTERM_PANE .. "-on-" .. basename(env.WEZTERM_UNIX_SOCKET)

			-- Generate a new argument array that will launch a
			-- program via systemd-run
			local wrapped = {
				"systemd-run",
				"--user",
				"--scope",
				"--description=Shell started by wezterm",
				"--same-dir",
				"--collect",
				"--unit=" .. ident,
			}

			-- Append the requested command
			-- Note that cmd.args may be nil; that indicates that the
			-- default program should be used. Here we're using the
			-- shell defined by the SHELL environment variable.
			for _, arg in ipairs(cmd.args or { os.getenv("SHELL") }) do
				table.insert(wrapped, arg)
			end

			-- replace the requested argument array with our new one
			cmd.args = wrapped

			-- and return the SpawnCommand that we want to execute
			return cmd
		end),
	}

	-- Making the domain the default means that every pane/tab/window
	-- spawned by wezterm will have its own scope
	config.default_domain = "scoped"
end

return module
