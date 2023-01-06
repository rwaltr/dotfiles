return { {
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
} }
