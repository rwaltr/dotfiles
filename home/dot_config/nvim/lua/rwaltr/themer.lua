-- Set up colorschemes
local colorscheme_themer = "radium"
local colorscheme_backup = "lunar"

-- Call In Themer
local status_ok, themer = pcall(require, "themer")

-- Load Legacy code if it does not work
if not status_ok then
  local colorscheme_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme_backup)

  -- Fail if nothing 🤷
  if not colorscheme_status_ok then
    vim.notify("colorscheme " .. colorscheme_backup .. " not found!")
    return
  end
  return
end

-- Set up themer if all goes well
-- https://github.com/themercorp/themer.lua#-configuring-themer
themer.setup({
  colorscheme = colorscheme_themer,
  styles = {
    ["function"]    = { style = 'italic' },
    functionbuiltin = { style = 'italic' },
    variable        = { style = 'italic' },
    variableBuiltIn = { style = 'italic' },
    parameter       = { style = 'italic' },
  },
  enable_installer = true,
})
