return {
	"nvim-focus/focus.nvim",
	-- version = "*", -- 使用稳定版
	version = false, -- 强制最新版
	event = "VeryLazy", -- 既然是 UI 插件，可以在启动后加载
	cond = not vim.g.vscode,

	opts = {
		-- 1. 开启自动调整大小 (核心功能)
		autoresize = {
			enable = true,
			width = 0, -- 0 表示基于黄金比例自动计算 (推荐)
			height = 0,
			minwidth = 20, -- 防止非活动窗口变得太窄，无法阅读
			minheight = 5, -- 防止非活动窗口变得太矮
			height_quickfix = 10, -- Quickfix 窗口保持固定高度
		},

		-- 2. UI 视觉调整 (增强焦点感)
		ui = {
			-- 当窗口激活时显示光标行，失焦时隐藏 (非常直观)
			cursorline = true,

			-- 以下选项建议关闭，否则切换窗口时行号和符号栏跳动会很晃眼
			number = false,
			relativenumber = false,
			signcolumn = false,
			cursorcolumn = false,
			colorcolumn = { enable = false },
		},

		-- 3. 黑名单 (非常重要！)
		-- 防止 Focus 去调整你的侧边栏、终端或浮动窗口的大小
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

		-- (可选) 使用 Focus 自带的分屏命令，它会自动处理光标跳转
		{ "<C-h>", "<cmd>FocusSplitLeft<cr>", desc = "Split Left" },
		{ "<C-l>", "<cmd>FocusSplitRight<cr>", desc = "Split Right" },
		{ "<C-j>", "<cmd>FocusSplitDown<cr>", desc = "Split Down" },
		{ "<C-k>", "<cmd>FocusSplitUp<cr>", desc = "Split Up" },
	},
}
