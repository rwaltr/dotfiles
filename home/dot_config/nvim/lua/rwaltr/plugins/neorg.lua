return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    cmd = "Neorg",
    ft = "norg",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.completion"] = {
          config = { engine = "nvim-cmp" },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              notebook = "~/Documents/Notebook"
            }
          }
        }
      },
    },
  },
}
