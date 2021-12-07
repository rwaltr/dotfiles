
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- My plugins here
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Bindly import new packages


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
  use {'vimwiki/vimwiki', opt=true}

  -- Which Key, But better
  use {'folke/which-key.nvim'}

  -- Inline Color preview
  -- https://github.com/norcalli/nvim-colorizer.lua
  use {'norcalli/nvim-colorizer.lua'}


  -- Git Integration
  use {'mhinz/vim-signify'}
  use {'tpope/vim-fugitive', opt=true,
  cmd={'G','Gedit','Git','Gsplit','Gread','Gwrite','Ggrep','Glgrep','GMove','GDelete','Gstatus','GBrowse'},
  requires = {'tpope/vim-rhubarb', opt=true}
   }
  use {'junegunn/gv.vim', opt=true,
  requires ={'tpope/vim-fugitive'},
  cmd = {'GV','GV!','GV?'}
   }
use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    require('gitsigns').setup()
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
        require('Comment').setup()
    end
}
  -- Autopairs
   use 'windwp/nvim-autopairs'

   -- LSPConfig
   use 'neovim/nvim-lspconfig'
   -- TODO: Setup lspsaga
use { 'tami5/lspsaga.nvim' }
   -- TODO: setup nvim-treesitter
   use {'nvim-treesitter/nvim-treesitter',
   run = ':TSUpdate'}

   -- LspInstall
   use 'williamboman/nvim-lsp-installer'

   -- colors for LSP that doesnt have current theme
   use 'folke/lsp-colors.nvim'
   use 'kyazdani42/nvim-web-devicons'


   -- autocompletion
   use {
     'hrsh7th/cmp-nvim-lsp',
     'hrsh7th/cmp-buffer',
     'hrsh7th/cmp-path',
     'hrsh7th/cmp-cmdline',
     'hrsh7th/nvim-cmp',
     'hrsh7th/cmp-vsnip',
     'hrsh7th/vim-vsnip'
   }
   -- TELESCOPIC
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } }
}
use 'nvim-lua/popup.nvim'

use 'nvim-lualine/lualine.nvim'

use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}

use 'jose-elias-alvarez/null-ls.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
