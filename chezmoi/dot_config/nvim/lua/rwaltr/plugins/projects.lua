return {
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "~/src/*/*",
        "~/.local/share/*",
        "~/Documents/Notebook/"
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim", tag = "0.1.0" },
      { "Shatur/neovim-session-manager" },
    },
    priority = 100,
  },
}
