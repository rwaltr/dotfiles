local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
-- ignore
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer is not working", "error")
  return
end

-- Have packer use a popup window
packer.init({
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      -- return require("packer.util").float({ border = "rounded" })
      return require("packer.util").float({})
    end,
  },
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- TODO: Change to lua form of cmd
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- TODO: https://github.com/folke/dot/blob/master/config/nvim/lua/util/packer.lua has some interesting package setups
return packer.startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -------------------------------------------------
  -- Telescope
  -- TELESCOPIC
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("rwaltr.plugins.telescope")
    end,
  })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    requires = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  })
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  ------------------------------------------
  -------------------------------------------------
  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("rwaltr.plugins.nvim-treesitter")
    end,
  })
  --[[ Comment Context ]]
  use("JoosepAlviste/nvim-ts-context-commentstring")

  --[[CONTEXT]]
  use({
    "lewis6991/nvim-treesitter-context", -- Show current context via TreeSitter
    config = function()
      require("treesitter-context").setup()
    end,
  })
  ------------------------------------------
  -- LSP

  -- LSPConfig
  use("neovim/nvim-lspconfig")

  -- LspInstall
  -- use({
  --   "williamboman/nvim-lsp-installer",
  -- })
  -- New LSP with Mason
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }

  -- TODO: Install
  --https://github.com/jayp0521/mason-null-ls.nvim

  -- LSP for non LSP items
  use({
    "jose-elias-alvarez/null-ls.nvim",
  })
  -- colors for LSP that does not have current
  use("folke/lsp-colors.nvim")

  -- LSP Information
  use({
    "ray-x/lsp_signature.nvim",
    config = function()
      require("rwaltr.plugins.lsp.signature")
    end,
  })
  -- Json enabled lsp settings
  use("tamago324/nlsp-settings.nvim")

  -- Lua settings helper
  use("folke/neodev.nvim")

  -- Config management
  use{"folke/neoconf.nvim"}

  -- LSP Status indicator
  use { "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  }
  -- LSP lines instead of being hidden
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  -- LSP Symbols
  use { 'simrat39/symbols-outline.nvim',
    config = function()
      require("symbols-outline").setup()
    end,
  }

  -- Rust tools
  use { 'simrat39/rust-tools.nvim' }
  use { "Saecki/crates.nvim",
    config = function()
      require("rwaltr.plugins.crates")
    end,
  }

  --[[ word highlighting ]]
  use { 'RRethy/vim-illuminate' }

  -- Folding tool

  use { 'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
  }

  --[[ Yaml Assistant ]]
  use {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
  }

  --[[ use treesitter to help spellcheck ]]
  use { 'lewis6991/spellsitter.nvim',
    config = function()
      require("spellsitter").setup()
    end }

  ------------------------------------------
  -- Autocompletion

  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("rwaltr.plugins.cmp_config")
    end,
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-calc",
    },
  })
  -----------------------------------------
  -- Snippits

  -- Snippit Engine
  use({ "L3MON4D3/LuaSnip",
    config = function()
      require("rwaltr.plugins.luasnip")
    end })
  -- Premade Snippits
  use("rafamadriz/friendly-snippets")

  ------------------------------------------
  -- Miscs
  -- Surround
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })
  -- Windows
  use { "anuvyklack/windows.nvim",
    requires = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end
  }

  -- pre-commit
  use 'ttibsi/pre-commit.nvim'

  -- Glow
  use({ "ellisonleao/glow.nvim" })

  -- peak lines
  use({ "nacro90/numb.nvim" })

  -- Startpage
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("rwaltr.plugins.alpha")
    end,
  })
  -- Discord
  use({
    "andweeb/presence.nvim",
    config = function()
      require("rwaltr.plugins.presence")
    end,
  })

  -- Buffer bye
  use("moll/vim-bbye")

  -- Project integration
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("rwaltr.plugins.project")
    end,
  })

  -- Inline Color preview
  -- https://github.com/norcalli/nvim-colorizer.lua
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })

  -- Tmux easypane
  -- TODO: Replace with better Tmux navigator
  use({ "christoomey/vim-tmux-navigator" })
  -- Highlight TODO comments
  use({
    "folke/todo-comments.nvim",
    config = function()
      require("rwaltr.plugins.todo")
    end,
  })

  -- Indenting Guides
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("rwaltr.plugins.indentline")
    end,
  })

  -- Bufferlines
  use({
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("rwaltr.plugins.bufferline")
    end,
    branch = "main",
  })
  use("nvim-lua/popup.nvim")
  -- StatusLine
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("rwaltr.plugins.lualine")
    end,
  })
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  })
  -- Sneeky sneeky
  use({"ggandor/leap.nvim",
  config = function ()
    require("leap").add_default_mappings()
  end})

  -- Chezmoi Integration
  --[[ use({ "alker0/chezmoi.vim" }) ]]

  -- Which Key, But better
  use({
    "folke/which-key.nvim",
    config = function()
      -- require("which-key").setup({})
      require("rwaltr.plugins.whichkey")
    end,
  })
  use({
    "akinsho/toggleterm.nvim",
    config = function()
      require("rwaltr.plugins.toggleterm")
    end,
    branch = "main"
  })

  -- Tree explorer

  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
    config = function()
      require("rwaltr.plugins.nvim-tree")
    end,
  })
  -- speed stuff
  use({
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
  })
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("rwaltr.plugins.notify")
    end,
  })

  use("kyazdani42/nvim-web-devicons")

  -- colorscheme from lunarvim
  use("LunarVim/Colorschemes")
  --
  -- Themer...
  use({
    "themercorp/themer.lua",
  })

  -- use({
  -- 	"kosayoda/nvim-lightbulb",
  -- 	config = function()
  -- 		require("rwaltr.plugins.lightbulb")
  -- 	end,
  -- })
  --
  -- schemastore
  use("b0o/schemastore.nvim")
  ------------------------------------------
  -- Git
  use({ "tpope/vim-fugitive", requires = { "tpope/vim-rhubarb" } })
  use({ "junegunn/gv.vim", requires = { "tpope/vim-fugitive" } })
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("rwaltr.plugins.gitsigns")
    end,
  })
  use({ "https://github.com/rhysd/conflict-marker.vim" })

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("rwaltr.plugins.diffview")
    end }

  -- GitHub
  use {
    'ldelossa/gh.nvim',
    requires = { { 'ldelossa/litee.nvim' } },
    config = function()
      require("rwaltr.plugins.gh")
    end
  }



  ------------------------------------------
  ------------------------------------------
  -- Editing
  -- New Commenting Plugin
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("rwaltr.plugins.comment")
    end,
  })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("rwaltr.plugins.autopairs")
    end,
  })

  -- Notetaking
  use({
    "renerocksai/telekasten.nvim",
    requires = {
      "renerocksai/calendar-vim",
    },
    config = function()
      require("rwaltr.plugins.telekasten")
    end,
  })

  use{"mickael-menu/zk-nvim",
  config = function ()
   require("zk").setup()
  end}
  
  ------------------------------------------
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
