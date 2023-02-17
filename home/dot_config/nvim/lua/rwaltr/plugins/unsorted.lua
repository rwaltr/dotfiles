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
    "echasnovski/mini.surround",
    keys = { "gz" },
    version = false,
    config = function()
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup({
        mappings = {
          add = "gza", -- Add surrounding in Normal and Visual modes
          delete = "gzd", -- Delete surrounding
          find = "gzf", -- Find surrounding (to the right)
          find_left = "gzF", -- Find surrounding (to the left)
          highlight = "gzh", -- Highlight surrounding
          replace = "gzr", -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      })
    end,
  },
  {
    "ttibsi/pre-commit.nvim",
    cmd = "Precommit",
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "echasnovski/mini.bufremove",
    enabled = true,
    event = "BufEnter",
    config = function()
      require("mini.bufremove").setup()
    end,
  },
  -- TODO: Replace with numToStr/Navigator.nvim
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "folke/trouble.nvim",
    config = true,
    cmd = { "Trouble", "TroubleToggle" },
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
    "cbochs/grapple.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "echasnovski/mini.align",
    event = "InsertEnter",
    config = function()
      require("mini.align").setup({})
    end,
  },
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      })
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
-- https://github.com/nvim-neotest/neotest -- look deeper into this when its time for DAP
-- AI
-- https://github.com/jackMort/ChatGPT.nvim
-- https://github.com/dense-analysis/neural

-- https://github.com/glacambre/firenvim
