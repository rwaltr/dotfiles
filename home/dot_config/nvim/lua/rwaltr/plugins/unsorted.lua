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
    event = "VeryLazy"
  },
  {
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
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end
  },
  -- TODO: Compare with https://github.com/echasnovski/mini.bufremove
  {
    "moll/vim-bbye",
    event = "VeryLazy"
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
    event = "VeryLazy"
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
    event = "VeryLazy"
  },
  {
    "mickael-menu/zk-nvim",
    event = "VeryLazy",
    config = function ()
     require("zk").setup() 
    end
  },
  {
    "nullchilly/fsread.nvim",
    cmd = { "FSRead", "FSToggle", "FSClear" }
  },
  {
    "jghauser/mkdir.nvim",
    event = "VeryLazy",
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
}


-- TODO: Check out the following items
-- https://github.com/nvim-neotest/neotest -- look deeper into this when its time for DAP
-- https://github.com/jbyuki/instant.nvim
-- https://github.com/jamestthompson3/nvim-remote-containers
-- https://github.com/nvim-neorg/neorg
-- https://github.com/x-motemen/ghq
-- https://github.com/jackMort/ChatGPT.nvim
-- https://github.com/dense-analysis/neural
-- https://github.com/iamcco/markdown-preview.nvim
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md
-- https://github.com/phaazon/mind.nvim
-- https://github.com/roobert/search-replace.nvim
-- https://github.com/shortcuts/no-neck-pain.nvim
-- https://github.com/folke/dot/tree/master/config/nvim
-- https://github.com/glacambre/firenvim again..
-- TODO: Install https://github.com/monaqa/dial.nvim
