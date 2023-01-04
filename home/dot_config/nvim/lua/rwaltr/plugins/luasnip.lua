-- TODO: https://github.com/garcia5/dotfiles/blob/master/files/nvim/lua/ag/plugin-conf/luasnip.lua
return {
  {
    "L3MON4D3/LuaSnip",
    event = "BufReadPre",
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
    config =
    {
      history = true, -- Keeps last snippit local to jump back
      updateevents = "TextChanged,TextChangedI", --update changes as you type
      enable_autosnippets = true, -- enables autosnippets?
      -- ext_opts = {
      --   [require("luasnip.util.types").choiceNode] = {
      --     active = {
      --       virt_text = { { "", "Orange" } },
      --     },
        -- },
      },
    },
  }
