-- TODO: Check out https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-base16.md
-- TODO: Check out https://github.com/folke/styler.nvim
return {
  {
    "LunarVim/ColorSchemes",
    priority = 1000,
    lazy = false,
    -- config = function ()
    --   vim.cmd("colorscheme tomorrow")
    -- end
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,

    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({
        style = "night",
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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  { "shaunsingh/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
  },
  { "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
  },
  { "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
  },
  { "rockyzhang24/arctic.nvim",
    lazy = false,
    priority = 1000,
    dependencies = "rktjmp/lush.nvim",
  },
  { "ray-x/starry.nvim",
    lazy = false,
    priority = 1000,
  },
  { "andersevenrud/nordic.nvim",
    lazy = false,
    priority = 1000,
  },
  { "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
  },
  { "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "jesseleite/nvim-noirbuddy",
    dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
    lazy = false,
    priority = 1000,
    opts = {
      preset = 'slate'
    }
  },


}
