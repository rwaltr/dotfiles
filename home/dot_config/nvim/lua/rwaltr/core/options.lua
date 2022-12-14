local options = {
	termguicolors = true, -- set term gui colors (most terminals support this)
	autoindent = true, --- Good auto indent
	backup = false, -- creates a backup file
	clipboard = "unnamedplus",
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	cursorline = true, --- Highlight current line
	expandtab = true, -- convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	foldexpr = "nvim_treesitter#foldexpr()",
	foldmethod = "expr",
	foldminlines = 15,
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, --- Ignoes case on searching
	incsearch = true, --- go to next search
	mouse = "nv", --- Allow Mouse in Normal and Visual mode
	compatible = false, --- Doesn't try to be old vim
	wrap = false, --- No line wrapping
	number = true, --- show numbers
	numberwidth = 4, -- set number column width to 2 {default 4}
	pumheight = 10, -- pop up menu height
	relativenumber = true, --- Show relativenumber
	ruler = true, --- Show Cusor all the time
	scrolloff = 12, --- starts scrolling before it hits the bottom or top of page
	shiftwidth = 2, --- 2 spaces per indent
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	sidescrolloff = 8,
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	smartcase = true, --- enable case sensitive when search contains case
	smartindent = true, -- make indenting smarter again
	smarttab = true, --- Smart tab detection
	softtabstop = 2, --- 2 spaces for tab
	splitbelow = true, --- Splits downards
	splitright = true, --- Splits right
	swapfile = false, -- creates a swapfile
	tabstop = 2,
	timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[set iskeyword+=-]])
