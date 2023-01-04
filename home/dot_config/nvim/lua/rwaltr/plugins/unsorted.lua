-- TODO: Separate unsorted into sorted category
return {
  {
    "stevearc/dressing.nvim",
    config = true,
    event = "VeryLazy"
  },

  -- TODO: Define Keymaps
  {
    "ziontee113/icon-picker.nvim",
    config = { disable_legacy_commands = true },
    cmd = { "IconPickerYank", "IconPickerInsert", "IconPickerNormal" },
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    config = true,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
  },
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
  },
  {
    "kylechui/nvim-surround",
    config = true,
    event = "InsertEnter"
  },
  {
    -- TODO: Compare with https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md
    enabled = true,
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = true, duration = 150 },
      })
    end,
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow"
  },
  {
    "ttibsi/pre-commit.nvim",
    cmd = "Precommit"
  },
  { "nacro90/numb.nvim" },
  {
    -- TODO: Check out https://github.com/toppair/peek.nvim
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "telekasten" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end
  },
  -- TODO: Compare with https://github.com/echasnovski/mini.bufremove
  {
    "moll/vim-bbye",
    cmd = "Bdelete",
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
    event = "BufReadPost"
  },

  -- TODO: Replace with numToStr/Navigator.nvim
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy"
  },
  {
    "nvim-lua/popup.nvim"
  },
  {
    "folke/trouble.nvim",
    config = true,
    cmd = { "Trouble", "TroubleToggle" }
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies =
    {
      { "ggandor/flit.nvim", config = { labeled_modes = "nv" } },
    },
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  { "kyazdani42/nvim-web-devicons" },
  {
    "akinsho/git-conflict.nvim",
    config = true,
    event = "BufReadPre"
  },
  {
    "mickael-menu/zk-nvim",
    ft = "markdown",
    config = function()
      require("zk").setup()
    end
  },
  {
    "nullchilly/fsread.nvim",
    cmd = { "FSRead", "FSToggle", "FSClear" }
  },
  {
    "jghauser/mkdir.nvim",
    event = "BufWritePre",
  },
  {
    "gpanders/editorconfig.nvim",
    event = "BufReadPre",
  },
  {
    "cbochs/grapple.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    -- TODO: Configure
    "pwntester/octo.nvim",
    cmd = "Octo",
    config = true,
  }
}


-- TODO: Check out the following items
-- https://github.com/nvim-neotest/neotest -- look deeper into this when its time for DAP
-- https://github.com/jbyuki/instant.nvim
-- https://github.com/jamestthompson3/nvim-remote-containers
-- https://github.com/nvim-neorg/neorg
-- https://github.com/jackMort/ChatGPT.nvim
-- https://github.com/dense-analysis/neural
-- https://github.com/phaazon/mind.nvim
-- https://github.com/roobert/search-replace.nvim
-- https://github.com/shortcuts/no-neck-pain.nvim
-- https://github.com/glacambre/firenvim again..
-- https://github.com/TimUntersberger/neogit
-- https://github.com/nvim-pack/nvim-spectre
-- https://github.com/smjonas/inc-rename.nvim
-- https://github.com/monaqa/dial.nvim
