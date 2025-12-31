-- lua/plugins/todo-comments.lua
return {
	"folke/todo-comments.nvim",
	cond = not vim.g.vscode,
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	-- 输入 :TodoTelescope 即可搜索所有待办
}
