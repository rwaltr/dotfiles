return {
  {
    "nullchilly/fsread.nvim",
    cmd = { "FSRead", "FSToggle", "FSClear" }
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    cmd = "Neorg",
    ft = "norg",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-neorg/neorg-telescope" }
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.integrations.telescope"] = {},
        ["core.norg.completion"] = {
          config = { engine = "nvim-cmp" },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              notebook = "~/Documents/Notebook",
            }
          }
        },
        ["core.norg.journal"] = {
          config = {
            workspace = "notebook"
          }
        },
      },
    },
  },
  {
    "phaazon/mind.nvim",
    config = true,
    cmd = { "MindOpenMain", "MindOpenProject", "MineOpenSmartProject", "MindReloadState" },
  },
  {
    "jubnzv/mdeval.nvim",
    config = true,
    enabled = false,
    opts = {},
    cmd = { "MdEval" },
    ft = { "markdown", "norg" },
  },
  { "jakewvincent/mkdnflow.nvim",
    enabled = true,
    config = true,
    ft = "markdown",
  },


}
