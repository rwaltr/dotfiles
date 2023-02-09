return {
  {
    "numToStr/Comment.nvim",
    event = "InsertEnter",
    dependencies = "which-key.nvim",
    config = function()
      local comment = require("Comment")

      comment.setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })

      local wk = require("which-key")
      wk.register({
        g = {
          c = {
            name = "Line comment",
            c = "Toggle comment",
            o = "Add comment after line",
            O = "Add comment before line",
            A = "Add comment at the end of the line",
          },
          b = {
            name = "Block comment",
            c = "Toggle comment",
            o = "Add comment after line",
            O = "Add comment before line",
          },
        },
      })

    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      local icon = require("rwaltr.util.icons")
      require("todo-comments").setup({
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = icon.ui.BUG, -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = icon.ui.Check, color = "info" },
          HACK = { icon = icon.ui.Fire, color = "warning" },
          WARN = { icon = icon.diagnostics.Warning, color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = icon.ui.Performance, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = icon.ui.Note, color = "hint", alt = { "INFO" } },
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          before = "", -- "fg" or "bg" or empty
          keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
          after = "fg", -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      })
    end,
  },
}
