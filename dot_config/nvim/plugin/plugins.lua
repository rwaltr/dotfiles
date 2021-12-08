
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- My plugins here
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


-- Tree explorer

use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
}

  -- Chezmoi Integration
  use {'Lilja/vim-chezmoi'}
  use {'alker0/chezmoi.vim'}

  -- Vimwiki
  use {'vimwiki/vimwiki', opt = true}

  -- Which Key, But better
  use {'folke/which-key.nvim',
	config = function()
		 require'which-key'.setup{}
		end
		}

  -- Inline Color preview
  -- https://github.com/norcalli/nvim-colorizer.lua
  use {'norcalli/nvim-colorizer.lua',
	config = function()
       require'colorizer'.setup()
			end
	}


  -- Git Integration
  use {'mhinz/vim-signify'}
  use {'tpope/vim-fugitive',
  cmd={'G','Gedit','Git','Gsplit','Gread','Gwrite','Ggrep','Glgrep','GMove','GDelete','Gstatus','GBrowse'},
  requires = {'tpope/vim-rhubarb'}
   }
  use {'junegunn/gv.vim',
  requires ={'tpope/vim-fugitive'},
  cmd = {'GV','GV!','GV?'}
   }
use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
	config = function()
		require'gitsigns'.setup()
		end
}
  -- Tmux easypane
  use {'christoomey/vim-tmux-navigator'}

  -- NORD
   use {'arcticicestudio/nord-vim'}

  -- New Commenting Plugin
use {
    'numToStr/Comment.nvim',
	config = function()
	  require'Comment'.setup()
		end
	}

  -- Autopairs
   use {'windwp/nvim-autopairs',
		 config = function()
	require'nvim-autopairs'.setup{}
			end
	}

   -- LSPConfig
   use 'neovim/nvim-lspconfig'

-- TODO: Setup lspsaga
use { 'tami5/lspsaga.nvim',
	config = function()
	require'lspsaga'.init_lsp_saga()
			end
	}

-- TODO: comment highlighting
  use {
    'folke/todo-comments.nvim',
    config = function ()
      require("todo-comments").setup()
    end
  }

	-- Blank line Indenting
use "lukas-reineke/indent-blankline.nvim"

   use {'nvim-treesitter/nvim-treesitter',
   run = ':TSUpdate',
	config = function()
	require'config.nvim-treesitter'
		end
		}

   -- LspInstall
   use {'williamboman/nvim-lsp-installer',
		config = function()
			require'config.lspinstall'
			end}

   -- colors for LSP that doesnt have current theme
   use 'folke/lsp-colors.nvim'
   use 'kyazdani42/nvim-web-devicons'


   -- autocompletion
	use {'nvim-cmp',
	config = function()
     require'config.cmp'
		end
		}

   use {
     'hrsh7th/cmp-nvim-lsp',
     'hrsh7th/cmp-buffer',
     'hrsh7th/cmp-path',
     'hrsh7th/cmp-cmdline',
     'hrsh7th/cmp-vsnip',
     'hrsh7th/vim-vsnip'
   }
   -- TELESCOPIC
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'},
		config = function()
			require'telescope'.setup{}
				end}
}

use {'nvim-telescope/telescope-fzf-native.nvim',
	run = 'make',
	requires = 'nvim-telescope/telescope.nvim',
	config = function()
		require('telescope').load_extension('fzf')			
		end

	}



use 'nvim-lua/popup.nvim'


-- StatusLine
use {'nvim-lualine/lualine.nvim',
	config = function()
	  require'lualine'.setup()
		end
		}

use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
	config = function()
		require'trouble'.setup{}
			end
}

use {'jose-elias-alvarez/null-ls.nvim',
	config = function()
   require'config.nullls'
		end
	}

-- neorg
-- TODO:Setup Neorg
use {'nvim-neorg/neorg'}


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
