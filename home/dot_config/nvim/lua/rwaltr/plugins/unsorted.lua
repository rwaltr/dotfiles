-- TODO: Separate unsorted into sorted category
return {
  -- TODO: Define Keymaps
  {
    "ziontee113/icon-picker.nvim",
    opts = { disable_legacy_commands = true },
    cmd = { "IconPickerYank", "IconPickerInsert", "IconPickerNormal" },
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = {
      snippit_engine = "luasnip",
    },
  },
  {
    "ttibsi/pre-commit.nvim",
    cmd = "Precommit",
  },

  -- TODO: Replace with numToStr/Navigator.nvim
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "jghauser/mkdir.nvim",
    event = "BufWritePre",
  },
  {
    "gpanders/editorconfig.nvim",
    event = "BufReadPre",
    conf = function()
      if vim.fn.has("nvim-0.9") then
        return false
      end
      return true
    end,
  },
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    "Pocco81/AbbrevMan.nvim",
    event = "BufReadPre",
    cmd = { "AMLoad", "AMUnload" },
    config = true,
  },
  {
    "0styx0/abbreinder.nvim",
    dependencies = { "0styx0/abbremand.nvim" },
    event = "BufRead",
    config = true,
  },
  {
    "ziontee113/color-picker.nvim",
    cmd = { "PickColor", "PickColorInsert" },
    config = function()
      require("color-picker")
    end,
  },
  {
    "stevearc/oil.nvim",
    config = true,
    event = "BufReadPre",
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qt",
  },

}

-- TODO: Check out the following items
-- Programming
-- https://github.com/Weissle/persistent-breakpoints.nvim
-- https://github.com/jay-babu/mason-nvim-dap.nvim
-- https://github.com/michaelb/sniprun -- THIS ONE BIG GOOD
-- https://github.com/nvim-neotest/neotest -- look deeper into this when its time for DAP
-- https://github.com/stevearc/overseer.nvim
-- AI
-- https://github.com/dense-analysis/neural
-- https://github.com/jackMort/ChatGPT.nvim
-- https://github.com/zbirenbaum/copilot.lua
-- Editing
-- https://github.com/jghauser/papis.nvim
-- https://github.com/potamides/pantran.nvim
-- UI
-- https://github.com/glacambre/firenvim
-- https://github.com/m4xshen/smartcolumn.nvim
-- https://github.com/miversen33/netman.nvim
-- https://github.com/mrjones2014/smart-splits.nvim
-- MISC
-- https://github.com/NFrid/due.nvim
-- https://github.com/bennypowers/nvim-regexplainer
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
-- https://github.com/monaqa/dial.nvim
-- https://github.com/mrjones2014/legendary.nvim
-- https://github.com/shortcuts/no-neck-pain.nvim
