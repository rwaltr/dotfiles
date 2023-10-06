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
}
