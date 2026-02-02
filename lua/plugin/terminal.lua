return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cond = not vim.g.vscode,
	config = function()
		require("toggleterm").setup({
			-- 1. 设置打开/关闭终端的快捷键
			-- 这里设置为 Ctrl + \ (反斜杠)
			open_mapping = [[<c-\>]],

			-- 2. 设置终端打开的方向
			-- 可选值: 'vertical' | 'horizontal' | 'tab' | 'float'
			direction = "float",

			-- 3. 设置浮动窗口的样式
			float_opts = {
				border = "curved", -- 圆角边框
				winblend = 1.0, -- 透明度 (0是不透明)
			},

			on_open = function(term)
				vim.cmd("startinsert!")
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				vim.opt_local.winbar = nil
			end,

			shell = vim.o.shell,
			-- shell = "pwsh",
		})

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			-- 按 Esc 变为普通模式 (方便复制粘贴或移动光标)
			vim.keymap.set("t", "<S-t>", [[<C-\><C-n>]], opts)
			-- 方便在终端和其他窗口之间切换
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		end

		-- 自动应用上面的按键映射
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
