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
-- Better window navigation (VSCode handles this differently)
if not vim.g.vscode then
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

	-- Diagnostic keymaps (VSCode handles diagnostics)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
else
	-- VSCode specific keymaps
	local vscode = require("vscode")

	-- Navigate between editor groups
	vim.keymap.set("n", "<C-h>", function()
		vscode.call("workbench.action.focusLeftGroup")
	end, opts)
	vim.keymap.set("n", "<C-l>", function()
		vscode.call("workbench.action.focusRightGroup")
	end, opts)
	vim.keymap.set("n", "<C-j>", function()
		vscode.call("workbench.action.focusBelowGroup")
	end, opts)
	vim.keymap.set("n", "<C-k>", function()
		vscode.call("workbench.action.focusAboveGroup")
	end, opts)

	-- Navigate between tabs
	vim.keymap.set("n", "<S-h>", function()
		vscode.call("workbench.action.previousEditor")
	end, opts)
	vim.keymap.set("n", "<S-l>", function()
		vscode.call("workbench.action.nextEditor")
	end, opts)

	-- Close editor
	vim.keymap.set("n", "<leader>bd", function()
		vscode.call("workbench.action.closeActiveEditor")
	end, { desc = "Close editor" })

	-- Split editor
	vim.keymap.set("n", "<leader>sv", function()
		vscode.call("workbench.action.splitEditorRight")
	end, { desc = "Split vertically" })
	vim.keymap.set("n", "<leader>sh", function()
		vscode.call("workbench.action.splitEditorDown")
	end, { desc = "Split horizontally" })
	vim.keymap.set("n", "<leader>sx", function()
		vscode.call("workbench.action.closeActiveEditor")
	end, { desc = "Close current split" })

	-- File explorer
	vim.keymap.set("n", "<leader>e", function()
		vscode.call("workbench.view.explorer")
	end, { desc = "Toggle Explorer" })

	-- Find files
	vim.keymap.set("n", "<leader>ff", function()
		vscode.call("workbench.action.quickOpen")
	end, { desc = "Find files" })

	-- Find in files (grep)
	vim.keymap.set("n", "<leader>fg", function()
		vscode.call("workbench.action.findInFiles")
	end, { desc = "Find in files" })

	-- Go to symbol
	vim.keymap.set("n", "<leader>gs", function()
		vscode.call("workbench.action.gotoSymbol")
	end, { desc = "Go to symbol" })
	-- Rename symbol
	vim.keymap.set("n", "<leader>rn", function()
		vscode.call("editor.action.rename")
	end, { desc = "Rename symbol" })
	-- Goto definition
	vim.keymap.set("n", "gd", function()
		vscode.call("editor.action.revealDefinition")
	end, { desc = "Go to definition" })
	-- Go to declaration
	vim.keymap.set("n", "gD", function()
		vscode.call("editor.action.revealDeclaration")
	end, { desc = "Go to declaration" })
	-- Go to references
	vim.keymap.set("n", "gr", function()
		vscode.call("editor.action.referenceSearch.trigger")
	end, { desc = "Go to references" })
	-- Show hovering
	vim.keymap.set("n", "K", function()
		vscode.call("editor.action.showHover")
	end, { desc = "Show hover" })
	-- Goto implementation
	vim.keymap.set("n", "gi", function()
		vscode.call("editor.action.goToImplementation")
	end, { desc = "Go to implementation" })
	-- formatDocument
	vim.keymap.set("n", "<leader>cf", function()
		vscode.call("editor.action.formatDocument")
	end, { desc = "Format document" })
	-- Quick fix
	vim.keymap.set("n", "<leader>ca", function()
		vscode.call("editor.action.quickFix")
	end, { desc = "Quick fix" })

	-- Toggle terminal
	-- vim.keymap.set("n", "<leader>\\", function()
	-- 	vscode.call("workbench.action.terminal.toggleTerminal")
	-- end, { desc = "Toggle terminal" })
end

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

-- Save files (only in regular Neovim, VSCode handles saving)
if not vim.g.vscode then
	-- Normal 模式下按 Ctrl+s 保存
	vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

	-- Insert 模式下按 Ctrl+s 保存 (并保持在编辑模式)
	-- <C-o> 允许你在插入模式下临时执行一个普通模式命令
	vim.keymap.set("i", "<C-s>", "<C-o>:w<cr>", { desc = "Save file" })

	-- (可选) 如果你也想支持 Visual 模式
	vim.keymap.set("v", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
end
