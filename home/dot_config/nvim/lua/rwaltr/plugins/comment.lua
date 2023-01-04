local function configcomment()
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
  which_key.register({
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
end


return {{
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = configcomment(),
}}
