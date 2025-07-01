return {
  {
    "nullchilly/fsread.nvim",
    cmd = { "FSRead", "FSToggle", "FSClear" },
  },
  {
    "epwalsh/obsidian.nvim",
    enabled = false,
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/personal/Notebook/",
        },
      },
    },
  },
  {
    "nvim-neorg/neorg",
    -- build = ":Neorg sync-parsers",
    -- version = "v7.0.0",
    build = false,
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
