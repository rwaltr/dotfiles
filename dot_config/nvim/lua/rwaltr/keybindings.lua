-- Keybindings

local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent=true }
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Window navigation
keymap("n", "<C-J>", "<C-W><C-J>", opts)
keymap("n", "<C-K>", "<C-W><C-K>", opts)
keymap("n", "<C-L>", "<C-W><C-L>", opts)
keymap("n", "<C-H>", "<C-W><C-H>", opts)
keymap("n", "<C-Q>", "<C-W><C-Q>", opts)
keymap("n", "<C-W>t", ":tabnew<CR>", opts)
keymap("n", "<C-W><C-t>", ":tabnew<CR>", opts)


-- Clear search highlights
keymap("n", "<C-c>", ":nohlsearch<CR>", opts)

-- Remap window splits
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- nvim tree
keymap("n", "<C-t>", ":NvimTreeToggle<CR>", opts)


-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Telescope
keymap("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>", opts)
