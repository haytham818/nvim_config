return {
	"RaafatTurki/corn.nvim",
	event = "VeryLazy", -- 或者 "LspAttach"
	cmd = { "Corn" }, -- 懒加载命令
	opts = {
		auto_cmds = true,

		sort_method = "severity",

		-- 作用域: 'line' (只显示当前行诊断) 或 'file' (显示整个文件诊断)
		scope = "line",

		-- 边框样式: 'single', 'double', 'rounded', 'solid', 'shadow'
		border_style = "rounded",

		-- 黑名单模式：在这些模式下不显示 (例如插入模式)
		blacklisted_modes = { "i", "v" },

		-- 过滤等级：不想看到的诊断等级可以加进去
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
