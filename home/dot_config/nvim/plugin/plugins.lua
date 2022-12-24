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
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.notify("Packer is not working", "error")
  return
end

-- Have packer use a popup window
packer.init({
  snapshot_path = fn.stdpath("config") .. "/snapshots",
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

-- TODO: Check out the following items
-- https://github.com/nvim-neotest/neotest -- look deeper into this when its time for DAP
-- https://github.com/jbyuki/instant.nvim
-- https://github.com/jamestthompson3/nvim-remote-containers
-- https://github.com/nvim-neorg/neorg
-- https://github.com/x-motemen/ghq

-- TODO: Install https://github.com/jackMort/ChatGPT.nvim
-- TODO: Install https://github.com/dense-analysis/neural
-- TODO: Install https://github.com/ziontee113/icon-picker.nvim
-- TODO: Install https://github.com/monaqa/dial.nvim
-- TODO: Install https://github.com/petertriho/nvim-scrollbar
-- TODO: Install https://github.com/ziontee113/icon-picker.nvim
-- TODO: Install https://github.com/debugloop/telescope-undo.nvim

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

  -- Replaces vim.select.ui
  use({ "nvim-telescope/telescope-ui-select.nvim", disable = true })

  -- Also replaces vim.select.ui
  use({
    "stevearc/dressing.nvim",
    -- config = function()
    --     require('dressing').setup()
    --   end,
  })

  -- Not a huge fan of this one
  use({ "nvim-telescope/telescope-project.nvim", disable = false })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
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
  use({ "nvim-treesitter/playground" })

  -- Fancy Comment generations
  use {
    "danymat/neogen",
    config = function()
        require('neogen').setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
}

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
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })

  -- TODO: Install https://github.com/jayp0521/mason-null-ls.nvim

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
  use({ "folke/neoconf.nvim" })

  -- LSP Status indicator
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })
  -- LSP lines instead of being hidden
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  -- LSP Symbols
  use({
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  })

  -- Rust tools
  use({ "simrat39/rust-tools.nvim" })
  use({
    "Saecki/crates.nvim",
    config = function()
      require("rwaltr.plugins.crates")
    end,
  })

  --[[ word highlighting ]]
  use({ "RRethy/vim-illuminate" })

  -- Folding tool

  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

  --[[ Yaml Assistant ]]
  use({
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
  })

  --[[ use treesitter to help spellcheck ]]
  use({
    "lewis6991/spellsitter.nvim",
    config = function()
      require("spellsitter").setup()
    end,
  })

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
  use({
    "L3MON4D3/LuaSnip",
    config = function()
      require("rwaltr.plugins.luasnip")
    end,
  })
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
    end,
  })
  -- Windows
  use({
    "anuvyklack/windows.nvim",
    requires = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  })

  -- pre-commit
  use("ttibsi/pre-commit.nvim")

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
  -- TODO: Replace with either...
  -- https://github.com/ahmedkhalf/project.nvim
  -- or https://github.com/GnikDroy/projections.nvim
  -- or https://github.com/rockerBOO/awesome-neovim/blob/main/README.md#project
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("rwaltr.plugins.project")
    end,
    disable = true,
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
  -- TODO: Replace with numToStr/Navigator.nvim
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
  use({
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  })

  -- Chezmoi Integration
  --[[ use({ "alker0/chezmoi.vim" }) ]]

  -- Which Key, But better
  use({
    "folke/which-key.nvim",
    config = function()
      require("rwaltr.plugins.whichkey")
    end,
  })

  -- legendary works with which-key
  use({
    "mrjones2014/legendary.nvim",
    tag = "v2.1.0", -- renovate: datasource=github-releases depName=mrjones2014/legendary.nvim
    requires = "kkharji/sqlite.lua",
    config = function()
      require("legendary").setup()
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    config = function()
      require("rwaltr.plugins.toggleterm")
    end,
    branch = "main",
  })

  -- Tree explorer
  -- TODO: Compare with https://github.com/nvim-neo-tree/neo-tree.nvim
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

  -- TODO: Maybe use https://github.com/vigoux/notifier.nvim
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

  use {'akinsho/git-conflict.nvim', tag = "*", config = function()
    require('git-conflict').setup()
  end}

  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("rwaltr.plugins.diffview")
    end,
  })

  -- GitHub
  use({
    "ldelossa/gh.nvim",
    requires = { { "ldelossa/litee.nvim" } },
    config = function()
      require("rwaltr.plugins.gh")
    end,
  })

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

  use({
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup()
    end,
  })

  -- Faster reading
  use({ "nullchilly/fsread.nvim" })

  -- Auto create parent dirs
  use ({'jghauser/mkdir.nvim'})

  -- Respect editorconfig
  use ({'gpanders/editorconfig.nvim'})

  -- Mark manager
  use {
    "cbochs/grapple.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- A fancy Scrollbar
  use({"petertriho/nvim-scrollbar",
    requires = {"lewis6991/gitsigns.nvim",},
    config = function ()
      require("scrollbar").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end
    })
  ------------------------------------------
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
