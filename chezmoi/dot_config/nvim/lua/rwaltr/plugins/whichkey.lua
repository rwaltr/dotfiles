return {
  {
    -- TODO: Migrate to LEGENDARY
    "mrjones2014/legendary.nvim",
    enabled = false,
    -- dependencies = "kkharji/sqlite.lua",
    name = "legendary.nvim",
    opts = {
      whichkey = { auto_register = true },
      lazy_nvim = { auto_register = true },
      extensions = {
        smart_splits = {}
      }
    },
  },
  {
    "folke/which-key.nvim",
    name = "which-key.nvim",
    dependencies = "legendary.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      local setup = {
        plugins = {
          spelling = { enabled = true },
        },
        key_labels = {
          ["<leader>"] = "SPC",
          ["<tab>"] = "TAB",
        },
        window = {
          border = "single", -- none, single, double, shadow
        },
      }


      local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local mappings = {
        ["A"] = { "<cmd>Alpha<cr>", "Alpha" },
        ["a"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        ["b"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
        ["e"] = { "<cmd>Neotree toggle float<cr>", "Explorer" },
        ["w"] = { "<cmd>w!<CR>", "Save" },
        ["q"] = { "<cmd>q!<CR>", "Quit" },
        ["c"] = { "<cmd>bdelete!<CR>", "Close Buffer" },
        ["v"] = { "<cmd>vsplit<CR>", "Vsplit" },
        ["h"] = { "<cmd>split<CR>", "Split" },
        f = {
          name = "Find",
          b = { "<cmd>Telescope buffers<cr>", "Checkout branch" },
          c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
          f = { "<cmd>Telescope find_files<cr>", "Find files" },
          F = { "<cmd>Telescope file_browser<cr>", "File Browser" },
          t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
          T = { "<cmd>TodoTelescope<cr>", "Todo Search" },
          s = { "<cmd>Telescope grep_string<cr>", "Find String" },
          h = { "<cmd>Telescope help_tags<cr>", "Help" },
          H = { "<cmd>Telescope highlights<cr>", "Highlights" },
          -- i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
          l = { "<cmd>Telescope resume<cr>", "Last Search" },
          M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
          r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
          R = { "<cmd>Telescope registers<cr>", "Registers" },
          k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
          C = { "<cmd>Telescope commands<cr>", "Commands" },
          p = { "<cmd>Telescope neovim-project discover<cr>", "Projects" },
          n = { "<cmd>Telescope notify<cr>", "Notification History" },
        },
        p = {
          name = "Lazy",
          i = { "<cmd>Lazy install<cr>", "Install" },
          s = { "<cmd>Lazy sync<cr>", "Sync" },
          S = { "<cmd>Lazy show<cr>", "Show" },
          u = { "<cmd>Lazy update<cr>", "Update" },
          h = { "<cmd>Lazy home<cr>", "Home" },
          r = { "<cmd>Lazy restore<cr>", "Restore" },
        },
        g = {
          name = "Git",
          j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
          k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
          l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
          p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
          r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
          R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
          s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
          S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
          u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
          o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
          b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
          c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
          -- C = { "<cmd>G commit<cr>", "Create commit" },
          d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Diff",
          },
        },
        l = {
          name = "LSP",
          a = { "<cmd>Telescope lsp_code_actions<cr>", "Code Action" },
          d = {
            "<cmd>Telescope diagnostics bufnr=0 <cr>",
            "Document Diagnostics",
          },
          w = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics",
          },
          f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
          i = { "<cmd>LspInfo<cr>", "Info" },
          I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
          j = {
            "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
          },
          k = {
            "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
          },
          l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
          q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
          r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
          s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
          S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
          },
        },
        t = {
          name = "Terminal",
          n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
          u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
          t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
          p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
          f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
          h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
          v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
        },
        T = {
          name = "Treesitter",
          h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
          p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
          r = { "<cmd>TSToggle rainbow<cr>", "Rainbow" },
        },
        L = { "<cmd> lua require('lsp_lines').toggle() <cr>", "Toggle LSP lines" },
        n = {
          name = "Neorg",
          i = { "<cmd> Neorg index<cr>", "Index" },
          j = { "<cmd> Neorg journal today<cr>", "Today's Journal" },
          J = { "<cmd> Neorg journal<cr>", "Journal" },
          r = { "<cmd> Neorg return<cr>", "Return" },
        },
      }

      wk.setup(setup)
      wk.register(mappings, opts)
    end
  },
}
