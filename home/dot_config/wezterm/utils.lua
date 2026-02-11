-- Utility helpers for WezTerm configuration

local M = {}

--- Returns true if WezTerm is running inside a Distrobox container.
--- Distrobox sets DISTROBOX_ENTER_PATH in the environment.
function M.is_distrobox()
	return os.getenv("DISTROBOX_ENTER_PATH") ~= nil
end

--- Returns true if WezTerm is running inside a Flatpak sandbox.
--- Flatpak sets FLATPAK_ID in the environment for sandboxed apps.
function M.is_flatpak()
	return os.getenv("FLATPAK_ID") ~= nil
end

--- Returns true if `cmd` can be executed on the host.
--- Probes via the appropriate host-escape mechanism:
---   * Distrobox  → distrobox-host-exec which <cmd>
---   * Flatpak    → flatpak-spawn --host which <cmd>
---   * Otherwise  → command -v <cmd>
---@param cmd string  The command name (no arguments) to probe.
function M.command_exists(cmd)
	local check
	if M.is_distrobox() then
		check = "distrobox-host-exec which " .. cmd .. " >/dev/null 2>&1"
	elseif M.is_flatpak() then
		check = "flatpak-spawn --host which " .. cmd .. " >/dev/null 2>&1"
	else
		check = "command -v " .. cmd .. " >/dev/null 2>&1"
	end
	return os.execute(check) == 0
end

--- Prepend the appropriate host-escape prefix to an argument list.
---   * Distrobox  → distrobox-host-exec <args...>
---   * Flatpak    → flatpak-spawn --host <args...>
---   * Otherwise  → args unchanged
--- Returns a new table; the original is not modified.
---@param args table  Argument list, e.g. { "systemd-run", "--user", ... }
---@return table
function M.maybe_host_wrap(args)
	local prefix
	if M.is_distrobox() then
		prefix = { "distrobox-host-exec" }
	elseif M.is_flatpak() then
		prefix = { "flatpak-spawn", "--host" }
	end

	if prefix then
		local wrapped = {}
		for _, v in ipairs(prefix) do
			table.insert(wrapped, v)
		end
		for _, v in ipairs(args) do
			table.insert(wrapped, v)
		end
		return wrapped
	end

	return args
end

return M
