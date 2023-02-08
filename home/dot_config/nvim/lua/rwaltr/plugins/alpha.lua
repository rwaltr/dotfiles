return { {
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
} }
