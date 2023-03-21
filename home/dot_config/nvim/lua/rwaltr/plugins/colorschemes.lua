-- TODO: Check out https://github.com/folke/styler.nvim
return {
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    enabled = true,
    priority = 1000,
  },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      require("bluloco").setup({
        style       = "dark", -- "auto" | "dark" | "light"
        transparent = false,
        italics     = false,
        terminal    = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
        guicursor   = true,
      })

      vim.cmd('colorscheme bluloco')
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({
        style = "night",
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
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
  { "tjdevries/colorbuddy.nvim",
    branch = "dev" },
  {
    -- 'rwaltr/goldenstag.nvim',
    name = "goldenstag.nvim",
    lazy = false,
    enabled = false,
    dir = "~/src/rwaltr/goldenstag.nvim",
    config = function()
      require("goldenstag").setup()
    end,
  },
}
