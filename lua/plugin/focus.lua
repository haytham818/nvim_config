return {
	"nvim-focus/focus.nvim",
	version = false,
	event = "VeryLazy",

	opts = {
		--自动调整大小
		autoresize = {
			enable = true,
			width = 0,
			height = 0,
			minwidth = 20,
			minheight = 5,
			height_quickfix = 10,
		},

		-- 2. UI
		ui = {
			-- 当窗口激活时显示光标行
			cursorline = true,

			number = false,
			relativenumber = false,
			signcolumn = false,
			cursorcolumn = false,
			colorcolumn = { enable = false },
		},

		-- 3. 黑名单
		excluded_filetypes = {
			"toggleterm", -- 终端
			"NvimTree", -- 文件树
			"neo-tree", -- 文件树
			"TelescopePrompt",
			"alpha", -- 启动页
			"dashboard",
			"lazy",
			"mason",
			"qf", -- Quickfix 列表
		},
		excluded_buftypes = { "nofile", "prompt", "popup" },
	},

	-- 4. 快捷键配置
	keys = {
		-- 快速切换 Focus 开关 (有时候你想手动控制窗口大小)
		{ "<leader>wf", "<cmd>FocusToggle<cr>", desc = "Toggle Auto Focus" },

		-- 强制让所有窗口等宽等高 (回到默认状态)
		{ "<leader>w=", "<cmd>FocusEqualise<cr>", desc = "Equalize Windows" },

		-- 最大化当前窗口 (类似 Zen Mode，再次按下恢复)
		{ "<leader>wm", "<cmd>FocusMaximise<cr>", desc = "Maximize Window" },

		{ "<C-h>", "<cmd>FocusSplitLeft<cr>", desc = "Split Left" },
		{ "<C-l>", "<cmd>FocusSplitRight<cr>", desc = "Split Right" },
		{ "<C-j>", "<cmd>FocusSplitDown<cr>", desc = "Split Down" },
		{ "<C-k>", "<cmd>FocusSplitUp<cr>", desc = "Split Up" },
	},
}
