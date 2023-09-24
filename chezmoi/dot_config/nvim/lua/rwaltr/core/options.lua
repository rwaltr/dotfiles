local options = {
  -- numberwidth = 3, -- set number column width to 2 {default 4}
  -- showtabline = 2, -- always show tabs
  autochdir = false, --Auto change dir
  autoindent = true, --- Good auto indent
  backup = false, -- creates a backup file
  clipboard = "unnamedplus",
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  compatible = false, --- Doesn't try to be old vim
  completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 3, -- so that `` is visible in markdown files
  cursorline = true, --- Highlight current line
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  foldexpr = "nvim_treesitter#foldexpr()",
  foldmethod = "expr",
  foldminlines = 25,
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, --- Ignoes case on searching
  incsearch = true, --- go to next search
  mouse = "a", --- Allow Mouse in Normal and Visual mode
  number = true, --- show numbers
  pumheight = 10, -- pop up menu height
  relativenumber = true, --- Show relativenumber
  ruler = true, --- Show Cusor all the time
  scrolloff = 5, --- starts scrolling before it hits the bottom or top of page
  shiftwidth = 2, --- 2 spaces per indent
  showmode = false, -- We have a statusline
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, --- enable case sensitive when search contains case
  smartindent = true, -- make indenting smarter again
  smarttab = true, --- Smart tab detection
  softtabstop = 2, --- 2 spaces for tab
  splitbelow = true, --- Splits downards
  splitright = true, --- Splits right
  swapfile = true, -- creates a swapfile
  tabstop = 2, -- Number of spaces tabs count for
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 200, -- faster cursorhold and swap writing
  wrap = false, --- No line wrapping
  autowrite = true,
  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --vimgrep --smart-case",
  hidden = true,
  list = true,
  undolevels = 10000, -- Space is cheap
  wildmode = "longest:full,full",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.cmd([[set iskeyword+=-]])
