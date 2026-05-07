return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = {
		"ToggleTerm",
		"ToggleTermToggleAll",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
		"ToggleTermSendCurrentLine",
		"ToggleTermSetName",
	},
	keys = {
		{ [[<c-\>]], "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle terminal" },
		{ [[<c-\>]], "<esc><cmd>ToggleTerm<cr>", mode = "i", desc = "Toggle terminal" },
	},
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],

			-- 'vertical' | 'horizontal' | 'tab' | 'float'
			direction = "float",

			-- 浮动窗口
			float_opts = {
				border = "curved",
				winblend = 1.0,
			},

			on_open = function(term)
				vim.cmd("startinsert!")
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				vim.opt_local.winbar = nil
			end,

			shell = vim.o.shell,
		})

		local term_group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })
		vim.api.nvim_create_autocmd("TermOpen", {
			group = term_group,
			pattern = "term://*",
			callback = function()
				local opts = { buffer = 0 }
				-- 按 S-t 变为普通模式 (方便复制粘贴或移动光标)
				vim.keymap.set("t", "<S-t>", [[<C-\><C-n>]], opts)
				-- 方便在终端和其他窗口之间切换
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end,
		})
	end,
}
