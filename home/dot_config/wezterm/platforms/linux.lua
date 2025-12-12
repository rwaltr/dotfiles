-- Linux-specific configuration for WezTerm
-- This module exports an apply_to_config function that modifies the config table

local module = {}

function module.apply_to_config(config)
  -- Enable Wayland if available (recommended for better performance)
  config.enable_wayland = true

  -- Linux-specific window decorations
  -- config.window_decorations = "TITLE | RESIZE"

  -- Better integration with tiling window managers
  -- Uncomment if you use i3, sway, bspwm, etc.
  -- config.window_padding = {
  --   left = 0,
  --   right = 0,
  --   top = 0,
  --   bottom = 0,
  -- }

  -- Linux-specific key bindings could go here
  -- config.keys = config.keys or {}
end

return module
