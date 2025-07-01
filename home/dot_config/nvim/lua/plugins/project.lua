return {
  { "persistence.nvim", enabled = false },
  {
    "coffebar/neovim-project",
    event = "BufReadPre",
    keys = {
      { "<leader>fp", "<cmd>Telescope neovim-project discover<cr>", desc = "Find project" },
      { "<leader>fP", "<cmd>NeovimProjectLoadRecent<cr>", desc = "open last project" },
    },
    opts = {
      projects = { -- define project roots
        "~/src/*/*",
        "~/.local/share/chezmoi",
        "~/Documents/Notebook",
      },
      session_manager_opts = {
        -- autosave_ignore_dirs = {},
        autosave_ignore_filetypes = {
          "neo-tree",
          "qf",
          "gitrebase",
          "gitcommit",
          "lazy",
          "help",
        },
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "Shatur/neovim-session-manager" },
    },
    priority = 100,
  },
}
