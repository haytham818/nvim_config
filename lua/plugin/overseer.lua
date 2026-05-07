-- lua/plugin/overseer.lua
return {
	"stevearc/overseer.nvim",
	event = "VeryLazy",
	opts = {
		dap = true,

		task_list = {
			direction = "right",
			min_height = 10,
			max_height = 25,
			default_detail = 1,
			-- 自定义快捷键
			keymaps = {
				["<C-j>"] = false,
				["<C-k>"] = false,
				["?"] = "ShowHelp",
				["<CR>"] = "RunAction",
				["<C-e>"] = "Edit",
				["o"] = "Open",
				["<C-v>"] = "OpenVsplit",
				["<C-s>"] = "OpenSplit",
				["<C-f>"] = "OpenFloat",
				["<C-q>"] = "OpenQuickFix",
				["p"] = "TogglePreview",
				["<C-l>"] = "IncreaseDetail",
				["<C-h>"] = "DecreaseDetail",
				["L"] = "IncreaseAllDetail",
				["H"] = "DecreaseAllDetail",
				["["] = "DecreaseWidth",
				["]"] = "IncreaseWidth",
				["{"] = "PrevTask",
				["}"] = "NextTask",
			},
		},

		form = {
			border = "rounded",
			zindex = 40,
		},
		task_win = {
			border = "rounded",
			padding = 2,
		},

		component_aliases = {
			default = {
				{ "display_duration", detail_level = 2 },
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},
	},

	keys = {
		{ "<leader>to", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer (Tasks)" },
		{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
		{ "<leader>ta", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
		{ "<leader>ti", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
		{ "<leader>tc", "<cmd>OverseerClearCache<cr>", desc = "Clear Task Cache" },
	},
}
