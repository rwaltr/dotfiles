local indentsymbol = "╎"
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      exclude = {
        -- filetypes = {}
      },
      scope = {
        exclude = {},
        include = {
          node_type = {
            lua = { "return_statement", "table_constructor" },
          },
        },
      },
      indent = {
        char = indentsymbol,
        tab_char = "⊣",
        smart_indent_cap = true,
        -- highlight = {"Function", "Label"},
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      symbol = indentsymbol,
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
}
