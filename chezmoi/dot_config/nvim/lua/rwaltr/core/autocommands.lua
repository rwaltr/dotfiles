--- Generate Augroup with rwaltr appended
---@param name string
---@return number augroup
local function augroup(name)
  return vim.api.nvim_create_augroup("rwaltr_" .. name, { clear = true })
end

-- Highlights on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Checks if we need to reload a file after working elsewhere
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Resize splits when window resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext" .. current_tab)
  end,
})

-- Go to last location when opening file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].rwaltr_last_loc then
      return
    end
    vim.b[buf].rwaltr_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some files with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- WRAPSPELL
vim.api.nvim_create_autocmd("Filetype", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "norg" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})


-- Set Yaml opts
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "yaml",
  group = augroup("yaml_opts"),
  callback = function()
    vim.api.nvim_set_option_value("ts", 2, { scope = "local" })
    vim.api.nvim_set_option_value("sts", 2, { scope = "local" })
    vim.api.nvim_set_option_value("sw", 2, { scope = "local" })
    vim.api.nvim_set_option_value("expandtab", true, { scope = "local" })
  end,
})

--- LEGACY BELOW
--#region chezmoi
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "**/.local/share/chezmoi/home/dot_config/nvim/**",
  callback = function()
    local job = require("plenary.job")
    job:new({
      -- TODO: a better notification
      command = "chezmoi",
      args = { "apply", "--source-path", vim.api.nvim_buf_get_name(0) },
      on_start = function()
        vim.notify("Writing for" .. vim.api.nvim_buf_get_name(0))
      end,
      on_exit = function()
        vim.notify("Chezmoi Complete")
      end,
    }):start()
  end,
  group = augroup("chezmoi"),
})

