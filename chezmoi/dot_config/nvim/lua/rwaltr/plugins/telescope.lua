return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end
      },
      {
        "debugloop/telescope-undo.nvim",
        config = function()
          require("telescope").load_extension("undo")
        end
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          require("telescope").load_extension("file_browser")
        end,
      },

    },
    opts = function(_, opts)
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          n = { s = flash },
          i = { ["<c-s>"] = flash }
        },
        prompt_prefix = require("rwaltr.util.icons").ui.Telescope .. "",
        selection_caret = require("rwaltr.util.icons").ui.Selection .. "",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/" },
      })
    end,
    -- config = function()
    --
    --   local icons = require("rwaltr.util.icons")
    --
    --   telescope.setup({
    --     defaults = {
    --
    --       prompt_prefix = icons.ui.Telescope .. " ",
    --       selection_caret = icons.ui.Selection .. " ",
    --       path_display = { "smart" },
    --       file_ignore_patterns = {
    --         ".git/",
    --       },
    --     }
    --   })
    -- end
  }
}
