return {
  {
    "nvim-tree/nvim-web-devicons",
    name = "nvim-web-devicons"
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    event = "VeryLazy",
    config = function()
      local icons = require("rwaltr.util.icons")
      require("notify").setup({
        -- Animation style (see below for details)
        stages = "fade_in_slide_out",

        -- Function called when a new window is opened, use for changing win settings/config
        on_open = nil,

        -- Function called when a window is closed
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
          return math.floor(vim.o.columns * 0.75)
        end,
        maximum_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,

        -- Icons for the different levels
        icons = {
          ERROR = icons.diagnostics.Error,
          WARN = icons.diagnostics.Warning,
          INFO = icons.diagnostics.Information,
          DEBUG = icons.ui.Bug,
          TRACE = icons.ui.Pencil,
        },
      })
      vim.notify = require("notify")
    end
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies =
    {
      { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } },
    },
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufEnter",
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    event = "UIEnter",
    config = true,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "rcarriga/nvim-notify" },
    },
    opts = {

      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      cmdline = {
        view = "cmdline"
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
        dashboard.button("F", icons.documents.Files .. " File Browser ", ":Telescope file_browser <CR>"),
        dashboard.button("e", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", icons.git.Repo .. " Find project", ":Telescope projections <CR>"),
        dashboard.button("r", icons.ui.History .. " Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", icons.type.String .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("N", icons.ui.Pen .. " New note", ":lua require('telekasten').new_templated_note()<CR>"),
        dashboard.button("n", icons.ui.Search .. " Search Notes", ":lua require('telekasten').find_notes()<CR>"),
        dashboard.button("d", icons.ui.Journal .. " Open Today's Note", ":lua require('telekasten').goto_today()<CR>"),
        dashboard.button("w", icons.ui.Journal .. " Open Week's Note", ":lua require('telekasten').goto_thisweek()<CR>"),
        dashboard.button("c", icons.ui.Gear .. " Configuration",
          ":e ~/.local/share/chezmoi/home/dot_config/nvim/init.lua <CR>"),
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
    end
  },
}
