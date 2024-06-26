return {
  {
    "nullchilly/fsread.nvim",
    cmd = { "FSRead", "FSToggle", "FSClear" },
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    version = "v7.0.0",
    cmd = "Neorg",
    ft = "norg",
    keys = {
      { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Neorg Index" },
      { "<leader>nj", "<cmd>Neorg journal<cr>", desc = "Neorg journal" },
      { "<leader>nr", "<cmd>Neorg return<cr>", desc = "Return from Neorg" },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-neorg/neorg-telescope" },
      {
        "which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>n"] = { name = "Neorg" },
          },
        },
      },
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
          config = { icon_preset = "diamond" },
        },
        ["core.integrations.telescope"] = {},
        ["core.completion"] = {
          config = { engine = "nvim-cmp" },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notebook = "~/Documents/Notebook",
            },
            default_workspace = "notebook",
          },
        },
        ["core.journal"] = {
          config = { workspace = "notebook" },
        },
        ["core.summary"] = {},
      },
    },
  },
  {
    "jakewvincent/mkdnflow.nvim",
    enabled = true,
    config = true,
    ft = "markdown",
  },
}
