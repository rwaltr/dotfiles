return {
  "themercorp/themer.lua",
  config = function()
    require("themer").setup({
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
}
