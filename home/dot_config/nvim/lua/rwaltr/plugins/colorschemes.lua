-- TODO: Check out https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-base16.md
-- TODO: Check out https://github.com/folke/styler.nvim
return {
  {
    "LunarVim/ColorSchemes",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd("colorscheme tomorrow")
    end
  },
 {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,

    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({
        style = "moon",
        sidebars = {
          "qf",
          "vista_kind",
          "terminal",
          "spectre_panel",
          "startuptime",
          "Outline",
        },
        on_highlights = function(hl, c)
          hl.CursorLineNr = { fg = c.orange, bold = true }
          local prompt = "#2d3149"
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = prompt }
          hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
          hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        end,
      })
      tokyonight.load()
    end,
  },
}
