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

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Normal 模式下按 Ctrl+s 保存
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Insert 模式下按 Ctrl+s 保存 (并保持在编辑模式)
-- <C-o> 允许你在插入模式下临时执行一个普通模式命令
vim.keymap.set("i", "<C-s>", "<C-o>:w<cr>", { desc = "Save file" })

-- (可选) 如果你也想支持 Visual 模式
vim.keymap.set("v", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
