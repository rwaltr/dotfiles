-- Yoink lazy.nvim latest
-- inspired by folke/LazyVim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- This pulls in all files located in `lua/rwaltr/plugins`
  -- Each file must return a table of valid specs
  -- see https://github.com/folke/lazy.nvim#-structuring-your-plugins
  spec = "rwaltr.plugins",
  defaults = { lazy = true, version = "*" }, -- attempts to install the latest of a tag, more stability hopefully
  install = { colorscheme = { "habamax" } }, -- Attempts to load colorscheme, otherwise loads build in habamax
  checker = { enabled = true }, -- Lazy checks for new versions
  -- Not sure why these are disabled will need to look more
-- performance = {
--     rtp = {
--       disabled_plugins = {
--         "gzip",
--         "matchit",
--         "matchparen",
--         "netrwPlugin",
--         "tarPlugin",
--         "tohtml",
--         "tutor",
--         "zipPlugin",
--       },
--     },
--   },
  -- TODO: Meld UI with rwaltr.util.icons
  -- https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
  -- ui = {},
})
