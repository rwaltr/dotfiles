return {
  {
    "nullchilly/fsread.nvim",
    cmd = { "FSRead", "FSToggle", "FSClear" },
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    cmd = "Neorg",
    ft = "norg",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-neorg/neorg-telescope" },
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {
          config = { icon_preset = "diamond" },
        },
        ["core.integrations.telescope"] = {},
        ["core.norg.completion"] = {
          config = { engine = "nvim-cmp" },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              notebook = "~/Documents/Notebook",
              work = "~/Documents/Notebook/work",
            },
            default_workspace = "notebook",
          },
        },
        ["core.norg.journal"] = {
          config = { workspace = "notebook" },
        },
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
