-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Better buffer navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffer without closing window
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Better split navigation
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- Clear search highlights (works in both)
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Better paste (don't yank replaced text) (works in both)
vim.keymap.set("v", "p", '"_dP', opts)

-- Move text up and down (works in both)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Save files
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<C-o>:w<cr>", { desc = "Save file" })
vim.keymap.set("v", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
