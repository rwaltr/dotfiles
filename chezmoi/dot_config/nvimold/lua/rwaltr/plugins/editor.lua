return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    dependencies = {
      {
        "miversen33/netman.nvim",
        cmd = { "Nmread", "Nmwrite", "Nmdelete" }
      },
    },
    keys = {
      { "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("rwaltr.util").get_root() })
        end,
        desc = "Neotree (Root Dir)"
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Neotree (cwd)"
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc() == 1 then
        ---@diagnostic disable-next-line: trailing-space, param-type-mismatch
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols", },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        use_libuv_file_watcher = true,
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_componet_configs = {
        indent = {
          with_expanders = true,
          expanders_collasped = require("rwaltr.util.icons").ui.ArrowClosed,
          expanders_expanded = require("rwaltr.util.icons").ui.ArrowOpen
        }
      }
    },
  },
  {
    "windwp/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    "folke/trouble.nvim",
    config = true,
    cmd = { "Trouble", "TroubleToggle" },
  },
  -- Regex Highlighting
  {
    "echasnovski/mini.bufremove",
    enabled = true,
    event = "BufEnter",
    config = function()
      require("mini.bufremove").setup()
    end,
  },
  {
    "echasnovski/mini.align",
    event = "InsertEnter",
    config = function()
      require("mini.align").setup({})
    end,
  },

  {
    "echasnovski/mini.bracketed",
    event = { "BufEnter" }
  },
  {
    -- https://github.com/gbprod/yanky.nvim#%EF%B8%8F-configuration
    "gbprod/yanky.nvim",
    event = { "BufEnter" },
    config = true,
  },
  -- Split managment
  { "mrjones2014/smart-splits.nvim" },
  -- Encode and decode text TODO: Setup keybinds
  { "MisanthropicBit/decipher.nvim" },
}
