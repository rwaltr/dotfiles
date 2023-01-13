local indentsymbol = "╎"
return { {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  config = function()
    local status_ok, indent_blankline = pcall(require, "indent_blankline")
    if not status_ok then
      return
    end

    vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
    vim.g.indent_blankline_filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "lazy",
      "neogitstatus",
      "NvimTree",
      "Trouble",
    }
    vim.g.indentLine_enabled = 1
    vim.g.indent_blankline_char = indentsymbol
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = true
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_current_context = false
    vim.g.indent_blankline_context_patterns = {
      "class",
      "return",
      "function",
      "method",
      "^if",
      "^while",
      "jsx_element",
      "^for",
      "^object",
      "^table",
      "block",
      "arguments",
      "if_statement",
      "else_clause",
      "jsx_element",
      "jsx_self_closing_element",
      "try_statement",
      "catch_clause",
      "import_statement",
      "operation_type",
    }

    -- vim.opt.listchars:append("space:⋅")
    vim.opt.listchars:append("eol:↴")

    indent_blankline.setup({
      show_end_of_line = false,
      show_current_context = false,
      show_current_context_start = true,
    })
  end
},
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup({
        symbol = indentsymbol,
        options = { try_as_border = true },
      })
    end,

  },
}
