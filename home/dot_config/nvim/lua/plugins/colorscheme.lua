-- Colorscheme: load DMS dank-theme if available, otherwise Catppuccin Mocha
local dank_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
local has_dank = vim.uv.fs_stat(dank_path) ~= nil

if has_dank then
  -- DMS (matugen) generates dankcolors.lua at runtime with base16 theme
  return dofile(dank_path)
end

-- Fallback: Catppuccin Mocha
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      term_colors = true,
      default_integrations = true,
      integrations = {
        diffview = true,
        flash = true,
        gitsigns = true,
        mason = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        noice = true,
        notify = true,
        snacks = true,
        telescope = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
