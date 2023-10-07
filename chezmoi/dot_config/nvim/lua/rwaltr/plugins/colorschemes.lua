-- TODO: Check out https://github.com/folke/styler.nvim
return {
  {
    "projekt0n/github-nvim-theme",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- require("github-theme").setup({
      --   -- ...
      -- })

      vim.cmd("colorscheme github_dark_dimmed")
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    enabled = true,
    priority = 1000,
  },
  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    enabled = true,
    priority = 1000,
    init = function()
      require("nightfox").setup()
    end,
    config = function ()
      vim.cmd("colorscheme nightfox")
    end
  },
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}
