-- lua/plugin/overseer.lua
return {
	"stevearc/overseer.nvim",
	event = "VeryLazy", -- 懒加载
	cond = not vim.g.vscode,
	opts = {
		-- 1. 启用 DAP 集成 (如果你使用 nvim-dap)
		dap = false,



		-- 2. 任务列表外观配置
		task_list = {
			direction = "right",
			min_height = 10,
			max_height = 25,
			default_detail = 1, -- 默认显示多少细节 (1 为显示一行输出)
			-- 自定义快捷键
			keymaps = {
				["<C-h>"] = false, -- 禁用默认的 ctrl-h/j/k/l 以防冲突
				["<C-j>"] = false,
				["<C-k>"] = false,
				["<C-l>"] = false,
				["?"] = "ShowHelp",
				["<CR>"] = "RunAction",
				["<C-e>"] = "Edit",
				["o"] = "Open",
				["<C-v>"] = "OpenVsplit",
                ["<C-s>"] = "OpenSplit",
				["<C-f>"] = "OpenFloat", -- 在浮动窗口打开输出
				["<C-q>"] = "OpenQuickFix",
				["p"] = "TogglePreview",
				["<C-l>"] = "IncreaseDetail", -- 增加显示细节
				["<C-h>"] = "DecreaseDetail", -- 减少显示细节
				["L"] = "IncreaseAllDetail",
				["H"] = "DecreaseAllDetail",
				["["] = "DecreaseWidth",
				["]"] = "IncreaseWidth",
				["{"] = "PrevTask",
				["}"] = "NextTask",
			},
		},

		-- 3. 浮动窗口样式 (跟随你的主题)
		form = {
			border = "rounded",
			zindex = 40,
		},
		task_win = {
			border = "rounded",
			padding = 2,
		},

		-- 4. 自定义组件别名 (可选)
		component_aliases = {
			-- 默认状态下，任务完成后会有通知，并且在成功时如果不输出则自动销毁
			default = {
				{ "display_duration", detail_level = 2 },
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},
	},
	-- 配置全局快捷键
	keys = {
		{ "<leader>to", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer (Tasks)" },
		{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
		{ "<leader>ta", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
		{ "<leader>ti", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
		{ "<leader>tc", "<cmd>OverseerClearCache<cr>", desc = "Clear Task Cache" },
	},
}
