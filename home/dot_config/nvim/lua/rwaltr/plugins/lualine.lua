return {
  {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    config = function()
      local status_ok, lualine = pcall(require, "lualine")
      if not status_ok then
        return
      end

      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      local icons = require("rwaltr.util.icons")

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = {
          error = icons.diagnostics.Error .. " ",
          warn = icons.diagnostics.Warning .. " ",
        },
        colored = false,
        update_in_insert = false,
        always_visible = false,
        padding = 1,
      }

      local diff = {
        "diff",
        colored = true,
        symbols = {
          added = icons.git.Add .. " ",
          modified = icons.git.Mod .. " ",
          removed = icons.git.Remove .. " ",
        }, -- changes diff symbols
        cond = hide_in_width,
        padding = 1,
      }

      local mode = {
        -- mode component
        function()
          return require("rwaltr.util.icons").misc.Vim
        end,
        padding = 1,
      }

      local filetype = {
        "filetype",
        icons_enabled = true,
        icon_only = true,
        icon = icons.documents.File,
        colored = false,
      }

      local branch = {
        "branch",
        icons_enabled = true,
        icon = icons.git.Branch,
        colored = false,
        padding = 1,
      }

      local location = {
        "location",
        padding = 1,
      }

      -- local fileformat = {
      --   "fileformat",
      --   padding = 0,
      -- }

      -- local filename = {
      --   "filename",
      --   padding = 0,
      -- }

      local progress = {
        "progress",
        ---@diagnostic disable-next-line: unused-local
        fmt = function(str)
          return "%P/%L"
        end,
        padding = 1,
      }
      local navic = {
        function()
          return require("nvim-navic").get_location()
        end,
        cond = function()
          return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
        end,
      }

      local filename = {
        "filename",
        path = 1,
      }

      local spaces = function()
        return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
      end

      lualine.setup({
        options = {
          globalstatus = true,
          icons_enabled = true,
          theme = "auto",
          -- component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "lazy", "neo-tree" },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { branch },
          lualine_c = { diagnostics, filetype, filename, navic },
          lualine_x = {
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has,
              color = { fg = "#ff9e64" },
            },
            --TODO: Add DAP {}
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
            },
            diff,
          },
          lualine_y = { spaces },
          lualine_z = { location, progress },
        },
        extensions = { "neo-tree", "symbols-outline", "lazy" },
      })
    end,
  },
}
