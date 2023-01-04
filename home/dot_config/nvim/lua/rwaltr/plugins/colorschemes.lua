return {
  {
    "themercorp/themer.lua",
    enabled = true,
    config = function()
      require("themer").setup({
        colorscheme = "onedark",
        styles = {
          ["function"]    = { style = 'italic' },
          functionbuiltin = { style = 'italic' },
          variable        = { style = 'italic' },
          variableBuiltIn = { style = 'italic' },
          parameter       = { style = 'italic' },
        },
        enable_installer = true,
      })
    end,
    lazy = false,
    priority = 1000,
  },
  {
    "LunarVim/ColorSchemes",
    lazy = false,
    priority = 1000,
  },
}
