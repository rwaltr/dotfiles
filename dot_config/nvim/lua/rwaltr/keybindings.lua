-- Keybindings

local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent=true }
local function nkeymap(key, map)
	keymap("n", key, map, opts)
end
nkeymap("gd", ":lua vim.lsp.buf.definition()<cr>")
nkeymap("gD", ":lua vim.lsp.buf.declaration()<cr>")
nkeymap("gi", ":lua vim.lsp.buf.implementation()<cr>")
nkeymap("gw", ":lua vim.lsp.buf.document_symbol()<cr>")
nkeymap("gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")
nkeymap("gr", ":lua vim.lsp.buf.references()<cr>")
nkeymap("gt", ":lua vim.lsp.buf.type_definition()<cr>")
nkeymap("K", ":lua vim.lsp.buf.hover()<cr>")
nkeymap("<c-k>", ":lua vim.lsp.buf.signature_help()<cr>")
nkeymap("<leader>af", ":lua vim.lsp.buf.code_action()<cr>")
nkeymap("<leader>rn", ":lua vim.lsp.buf.rename()<cr>")


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
keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fG", ":lua require('telescope.builtin').git_files()<CR>", opts)
keymap("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>", opts)
keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", opts)
keymap("n", "<leader>fF", ":lua require('telescope.builtin').file_browser()<CR>", opts)
