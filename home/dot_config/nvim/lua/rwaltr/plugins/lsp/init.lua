return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      "tamago324/nlsp-settings.nvim",
      "folke/lsp-colors.nvim",
      {
        "ray-x/lsp_signature.nvim", config = function()
          require("rwaltr.plugins.lsp.signature")
        end
      },
      {
        "j-hui/fidget.nvim",
        config = true,
        event = "VeryLazy"
      },
      -- {
      --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      --   config = true,
      --   event = "VeryLazy"
      -- },
      {
        "simrat39/symbols-outline.nvim",
        config = true,
      },
      "someone-stole-my-name/yaml-companion.nvim",
      { "folke/neodev.nvim", config = true },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("rwaltr.plugins.lsp.mason")
      require("rwaltr.plugins.lsp.handlers").setup()
      require("rwaltr.plugins.lsp.null-ls")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
  },
  { "b0o/schemastore.nvim" },
}
