return {
	"RaafatTurki/corn.nvim",
	event = "VeryLazy", -- 或者 "LspAttach"
	cmd = { "Corn" }, -- 懒加载命令
	opts = {
		auto_cmds = true,

		sort_method = "severity",

		scope = "line",

		border_style = "rounded",

		blacklisted_modes = { "i", "v" },

		blacklisted_severities = { vim.diagnostic.severity.HINT },

		on_toggle = function(is_hidden)
			vim.diagnostic.config({ virtual_text = is_hidden })
		end,
	},
	keys = {
		-- 常用快捷键配置
		{ "<leader>cd", "<cmd>Corn toggle<cr>", desc = "Toggle Corn Diagnostics" },
		{ "<leader>cs", "<cmd>Corn scope_cycle<cr>", desc = "Cycle Corn Scope (Line/File)" },
		{ "<leader>cr", "<cmd>Corn render<cr>", desc = "Refresh Corn" },
	},
}
