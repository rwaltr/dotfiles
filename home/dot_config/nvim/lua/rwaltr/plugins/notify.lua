-- TODO: Maybe use https://github.com/vigoux/notifier.nvim
return { {
  "rcarriga/nvim-notify",
  lazy = false,
  event = "VeryLazy",
  config = function()
    local icons = require("rwaltr.util.icons")
    require("notify").setup({
      -- Animation style (see below for details)
      stages = "fade_in_slide_out",

      -- Function called when a new window is opened, use for changing win settings/config
      on_open = nil,

      -- Function called when a window is closed
      on_close = nil,

      -- Render function for notifications. See notify-render()
      render = "default",

      -- Default timeout for notifications
      timeout = 3000,

      -- For stages that change opacity this is treated as the highlight behind the window
      -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
      background_colour = "Normal",

      -- Minimum width for notification windows
      maximum_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      maximum_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,

      -- Icons for the different levels
      icons = {
        ERROR = icons.diagnostics.Error,
        WARN = icons.diagnostics.Warning,
        INFO = icons.diagnostics.Information,
        DEBUG = icons.ui.Bug,
        TRACE = icons.ui.Pencil,
      },
    })
    vim.notify = require("notify")


  end
} }
