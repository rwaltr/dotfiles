-- This is where we keep the snippits https://youtu.be/ct1-zq8gf_0?t=19
-- TODO: https://github.com/garcia5/dotfiles/blob/master/files/nvim/lua/ag/plugin-conf/luasnip.lua
return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    init = function()
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippits/" })
    end,
    dependencies =
    {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")
      local icons = require("rwaltr.util.icons")
      ls.setup({
        history = true, -- Keeps last snippit local to jump back
        updateevents = "TextChanged,TextChangedI", --update changes as you type
        enable_autosnippets = true, -- enables autosnippets?
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { icons.ui.ArrowLeft, "Error" } }
            }
          }

        }
      }
      )
    end,

  },
}
