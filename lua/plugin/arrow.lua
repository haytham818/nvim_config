return {
	"otavioschwanck/arrow.nvim",
	event = "BufReadPre",
	cond = not vim.g.vscode,
	opts = {
		show_icons = true,
		leader_key = ";", -- 推荐：使用分号作为前缀键 (比如 ; + 1 跳转)
		buffer_leader_key = "m", -- 使用 m 来标记/取消标记当前文件
	},
	keys = {
		{ ";", desc = "Open Arrow Menu" },
		{ "m", desc = "Arrow Toggle Mark" },
	},
}
