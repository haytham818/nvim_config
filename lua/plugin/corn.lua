return {
	"RaafatTurki/corn.nvim",
	event = "VeryLazy", -- 或者 "LspAttach"
	cmd = { "Corn" }, -- 懒加载命令
	cond = not vim.g.vscode,
	opts = {
		-- 开启自动命令（自动显示诊断）
		auto_cmds = false,

		-- 排序方式: 'severity' (严重程度), 'column' (列号), 'line_number' (行号)
		sort_method = "severity",

		-- 作用域: 'line' (只显示当前行诊断) 或 'file' (显示整个文件诊断)
		-- 推荐先用 'line'，因为 'file' 可能会在角落显示太多内容
		scope = "line",

		-- 边框样式: 'single', 'double', 'rounded', 'solid', 'shadow'
		border_style = "rounded",

		-- 黑名单模式：在这些模式下不显示 (例如插入模式)
		blacklisted_modes = { "i", "v" },

		-- 过滤等级：不想看到的诊断等级可以加进去
		-- blacklisted_severities = { vim.diagnostic.severity.HINT },

		-- 切换时的回调（可选）
		on_toggle = function(is_hidden)
			-- 这是一个很棒的技巧：
			-- 当 Corn 显示时，关闭原生的行内诊断文字，避免重复和杂乱
			-- 当 Corn 隐藏时，恢复原生诊断
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
