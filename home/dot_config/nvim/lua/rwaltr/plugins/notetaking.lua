return {
  {
    "nullchilly/fsread.nvim",
    cmd = { "FSRead", "FSToggle", "FSClear" },
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    cmd = "Neorg",
    -- HACK Remove when https://github.com/nvim-neorg/neorg/issues/1002
    commit = "e76f0cb6b3ae5e990052343ebb73a5c8d8cac783",
    ft = "norg",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-neorg/neorg-telescope",
        commit = "d24f445c912451ddbf17cbe8da36561b51b10d39", },
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
        ["core.summary"] = {}
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
