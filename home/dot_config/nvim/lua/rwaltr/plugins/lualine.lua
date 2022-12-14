local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local icons = require("rwaltr.util.icons")

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = {
    error = icons.diagnostics.Error .. " ",
    warn = icons.diagnostics.Warning .. " "
  },
  colored = false,
  update_in_insert = false,
  always_visible = false,
  padding = 1,
}

local diff = {
  "diff",
  colored = false,
  symbols = {
    added = icons.git.Add .. " ",
    modified = icons.git.Mod .. " ",
    removed = icons.git.Remove .. " "
  }, -- changes diff symbols
  cond = hide_in_width,
  padding = 1,
}


local mode = {
  -- mode component
  function()
    return ""
  end,
  -- color = function ()
  --   return { fg = mode_color[vim.fn.mode()], bg = gray }
  -- end,
  padding = 1,
}

local filetype = {
  "filetype",
  icons_enabled = true,
  icon = icons.documents.File,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = icons.git.Branch,
  colored = false,
  padding = 1,
}

local location = {
  "location",
  padding = 1,
}


-- local fileformat = {
--   "fileformat",
--   padding = 0,
-- }

-- local filename = {
--   "filename",
--   padding = 0,
-- }

local progress = {
  "progress",
  fmt = function(str)
    return "%P/%L"
  end,
  padding = 1,
}

local spaces = function()
  return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode, branch },
    lualine_b = { diff, diagnostics },
    lualine_c = {},
    lualine_x = { spaces },
    lualine_y = { filetype },
    lualine_z = { location, progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { 'nvim-tree', 'symbols-outline' },
})
