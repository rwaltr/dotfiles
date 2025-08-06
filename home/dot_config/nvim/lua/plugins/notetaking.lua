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
    "jakewvincent/mkdnflow.nvim",
    enabled = true,
    config = true,
    ft = "markdown",
  },
}
