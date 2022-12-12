-- Move options, keybindings, other things to rwaltr.core
require("rwaltr.options")
require("rwaltr.keybindings")
require("rwaltr.themer")
require("rwaltr.autocommands")
-- Refactor lsp
require("rwaltr.lsp")
-- Migrate plugins.lua to be part of either init.lua or rwaltr.plugins
require("rwaltr.neovide")
