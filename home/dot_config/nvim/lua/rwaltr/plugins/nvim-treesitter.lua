return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      {
        "lewis6991/nvim-treesitter-context",
        config = true
      },
      {
        "lewis6991/spellsitter.nvim",
        config = true,
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        auto_install = true,
        ensure_installed = {
          "bash",
          "go",
          "hcl",
          "help",
          "html",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "vim",
          "yaml",
        },
        autopairs = { enable = true },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "" }, -- list of language that will be disabled
          additional_vim_regex_highlighting = false, --[[ Disabled for spellsitter ]]
        },
        indent = { enable = true, disable = { "yaml" } },
        context_commentstring = { enable = true, enable_autocmd = false },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    build = ":TSInstall query",
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable" },
    config = true,
  }
}
