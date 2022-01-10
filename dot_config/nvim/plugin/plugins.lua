local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
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
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | silent exec "!chezmoi apply ~/.config/nvim" 
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return packer.startup(function(use)
	-- My plugins here
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Colorscheme for WAL
	use({
		"oncomouse/lushwal",
		requires = {
			{ "rktjmp/lush.nvim", opt = true },
			{ "rktjmp/shipwright.nvim", opt = true },
			config = function()
				require("rwaltr.lushwal")
			end,
		},
	})
	use("tamago324/nlsp-settings.nvim")
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("rwaltr.notify")
		end,
	})
	-- colorscheme from lunarvim
	use("LunarVim/Colorschemes")
	use("lunarvim/darkplus.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	-- speed stuff
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient").enable_profile()
		end,
	})
	-- Tree explorer

	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			require("rwaltr.nvim-tree")
		end,
	})
	-- Discord
	use({
		"andweeb/presence.nvim",
		config = function()
			require("rwaltr.presence")
		end,
	})
	-- Chezmoi Integration
	use({ "Lilja/vim-chezmoi" })
	use({ "alker0/chezmoi.vim" })

	-- Which Key, But better
	use({
		"folke/which-key.nvim",
		config = function()
			-- require("which-key").setup({})
			require("rwaltr.whichkey")
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("rwaltr.toggleterm")
		end,
	})
	-- Github fanciness
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("rwaltr.octo")
		end,
	})
	-- Project integration
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("rwaltr.project")
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
	-- Sneeky sneeky
	use("ggandor/lightspeed.nvim")
	-- Startpage
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("rwaltr.alpha")
		end,
	})
	-- Buffer bye
	use("moll/vim-bbye")
	-- Git Integration
	use({ "tpope/vim-fugitive", requires = { "tpope/vim-rhubarb" } })
	use({ "junegunn/gv.vim", requires = { "tpope/vim-fugitive" } })
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("rwaltr.gitsigns")
		end,
	})
	-- Tmux easypane
	use({ "christoomey/vim-tmux-navigator" })

	-- -- WebBrowser funness
	-- use({
	-- 	"glacambre/firenvim",
	-- 	run = function()
	-- 		vim.fn["firenvim#install"](0)
	-- 	end,
	-- })
	-- NORD
	use({ "arcticicestudio/nord-vim" })

	-- New Commenting Plugin
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("rwaltr.comment")
		end,
	})

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("rwaltr.autopairs")
		end,
	})

	-- LSPConfig
	use("neovim/nvim-lspconfig")

	use({
		"folke/todo-comments.nvim",
		config = function()
			require("rwaltr.todo")
		end,
	})

	-- Blank line Indenting
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("rwaltr.indentline")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("rwaltr.nvim-treesitter")
		end,
	})

	-- LspInstall
	use({
		"williamboman/nvim-lsp-installer",
	})

	-- colors for LSP that does not have current theme
	use("folke/lsp-colors.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- autocompletion
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("rwaltr.cmp_config")
		end,
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
	})

	-- Bufferlines
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("rwaltr.bufferline")
		end,
	})

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	-- TELESCOPIC
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("rwaltr.telescope")
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

	use("nvim-lua/popup.nvim")

	-- StatusLine
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("rwaltr.lualine")
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
	})

	-- use({
	-- 	"nvim-neorg/neorg",
	-- 	config = function()
	-- 		require("rwaltr.neorg")
	-- 	end,
	-- 	requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
	-- })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
