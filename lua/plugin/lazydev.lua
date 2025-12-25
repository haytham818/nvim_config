return {
	"folke/lazydev.nvim",
	ft = "lua", -- 仅在 lua 文件中加载
	cond = not vim.g.vscode,
	opts = {
		library = {
			-- 自动加载你的插件目录，提供插件的 API 补全
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
}
