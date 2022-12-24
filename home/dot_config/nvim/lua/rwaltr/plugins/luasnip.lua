local ls = require("luasnip")

ls.loaders.from_lua.load({ paths = "~/.config/nvim/snippets/" })
ls.loaders.from_vscode.lazy_load()

-- TODO: https://github.com/garcia5/dotfiles/blob/master/files/nvim/lua/ag/plugin-conf/luasnip.lua

ls.config.set_config({
  history = true, -- Keeps last snippit local to jump back
  updateevents = "TextChanged,TextChangedI", --update changes as you type
  enable_autosnippets = true, -- enables autosnippets?
  ext_opts = {
    [require("luasnip.util.types").choiceNode] = {
      active = {
        virt_text = { { "", "Orange" } },
      },
    },
  },
})

