-- Icons
Icons = require("rwaltr.util.icons")
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose unpinned<CR>", desc = "Delete non-pined Buffers" },
    },
    enabled = true,
    opts = {
      options = {
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("rwaltr.util.icons")
          local ret = (diag.error and icons.diagnostics.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.diagnostics.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-Tree",
            text_alight = "left",
            highlight = "Directory",
          },
        },
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    init = function()
      vim.g.navic_silence = true
      require("rwaltr.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("rwaltr.util.icons").kind,
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "notify",
          "toggleterm",
          "lazyterm",
        }
      },
      scope = { enabled = false, },
      indent = {
        char = Icons.ui.Indent,
        tab_char = Icons.ui.Indent,
        smart_indent_cap = true,
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      symbol = Icons.ui.Indent,
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          globalstatus = true,
          icons_enabled = true,
          theme = "auto",
          always_divide_middle = true,
          disabled_filetypes = { "alpha", "dashboard", "neo-tree", "lazy" }
        },
        sections = {
          lualine_a = {
            {
              function()
                return Icons.misc.Vim
              end,
              padding = 1,
            },
          },
          lualine_b = { { "branch", icons_enabled = true, colored = false, padding = 1 }, },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = Icons.diagnostics.Error,
                warn = Icons.diagnostics.Warn,
                info = Icons.diagnostics.Info,
                hint = Icons.diagnostics.Hint,
              },
            },
            {
              "filetype",
              icons_enabled = true,
              icons_only = true,
              colored = false,
              always_visible = false,
              padding = 1,
            },
            {
              "filename",
              path = 0,
            },
          },
          lualine_x = {
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
            },
            {
              "diff",
              colored = true,
              symbols = {
                added = Icons.git.Add .. " ",
                modified = Icons.git.Mod .. " ",
                removed = Icons.git.Remove .. " ",
              },
              cond = function() return vim.fn.winwidth(0) > 80 end,
              padding = 1,
            },
          },

          lualine_y = {
            function()
              return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
            end
          },

          lualine_z = {
            {
              "location", padding = 1,
            },
            {
              "progress",
              ---@diagnostic disable-next-line: unused-local
              fmt = function(str)
                return "%P/%L"
              end,
              padding = 1,
            },
          },
        },
        extensions = { "neo-tree", "symbols-outline", "lazy" },
      }
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    init = function()
      local Util = require("rwaltr.util")
      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
    opts = {
      -- Animation style (see below for details)
      stages = "fade_in_slide_out",
      -- Function called when a new window is opened, use for changing win settings/config
      ---@diagnostic disable-next-line: assign-type-mismatch
      on_open = nil,
      -- Function called when a window is closed
      ---@diagnostic disable-next-line: assign-type-mismatch
      on_close = nil,
      -- Render function for notifications. See notify-render()
      render = "default",
      -- Default timeout for notifications
      timeout = 3000,
      -- For stages that change opacity this is treated as the highlight behind the window
      -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
      background_colour = "Normal",
      -- Minimum width for notification windows
      maximum_width = function()
        return math.floor(vim.o.columns * 0.30)
      end,
      maximum_height = function()
        return math.floor(vim.o.lines * 0.40)
      end,
      -- Icons for the different levels
      icons = {
        ERROR = Icons.diagnostics.Error,
        WARN = Icons.diagnostics.Warning,
        INFO = Icons.diagnostics.Information,
        DEBUG = Icons.ui.Bug,
        TRACE = Icons.ui.Pencil,
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "nacro90/numb.nvim",
    event = "BufReadPost",
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "rcarriga/nvim-notify" },
    },
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      cmdline = {
        view = "cmdline",
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local icons = require("rwaltr.util.icons")

      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[ _______                        __   __              ]],
        [[|       \                      |  \ |  \             ]],
        [[| ▓▓▓▓▓▓▓\__   __   __  ______ | ▓▓_| ▓▓_    ______  ]],
        [[| ▓▓__| ▓▓  \ |  \ |  \|      \| ▓▓   ▓▓ \  /      \ ]],
        [[| ▓▓    ▓▓ ▓▓ | ▓▓ | ▓▓ \▓▓▓▓▓▓\ ▓▓\▓▓▓▓▓▓ |  ▓▓▓▓▓▓\]],
        [[| ▓▓▓▓▓▓▓\ ▓▓ | ▓▓ | ▓▓/      ▓▓ ▓▓ | ▓▓ __| ▓▓   \▓▓]],
        [[| ▓▓  | ▓▓ ▓▓_/ ▓▓_/ ▓▓  ▓▓▓▓▓▓▓ ▓▓ | ▓▓|  \ ▓▓      ]],
        [[| ▓▓  | ▓▓\▓▓   ▓▓   ▓▓\▓▓    ▓▓ ▓▓  \▓▓  ▓▓ ▓▓      ]],
        [[ \▓▓   \▓▓ \▓▓▓▓▓\▓▓▓▓  \▓▓▓▓▓▓▓\▓▓   \▓▓▓▓ \▓▓      ]],
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", icons.documents.Files .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", icons.git.Repo .. " Find project", ":Telescope neovim-project discover <CR>"),
        dashboard.button("r", icons.ui.History .. " Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", icons.type.String .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("w", icons.ui.Journal .. " Open Notebook", ":Neorg workspace notebook <CR>"),
        dashboard.button("j", icons.ui.Pencil .. " Open Today's Journal", ":Neorg journal today <CR>"),
        dashboard.button("q", icons.ui.SignOut .. " Quit Neovim", ":qa<CR>"),
      }

      local function footer()
        return "rwaltr"
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true

      -- Close Lazy and reopen when dashboard is good.
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      alpha.setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 0.75,
      },
    },
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
  },
  { "shortcuts/no-neck-pain.nvim", version = "*", cmd = "NoNeckPain" },
  { "nvim-tree/nvim-web-devicons" },
}
