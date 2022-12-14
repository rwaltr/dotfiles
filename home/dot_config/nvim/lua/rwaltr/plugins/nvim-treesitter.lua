local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

configs.setup({
  ensure_installed = { "lua", "yaml", "json", "markdown", "hcl", "go" }, -- one of "all", or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  auto_install = true,
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false, --[[ Disabled for spellsitter ]]
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
