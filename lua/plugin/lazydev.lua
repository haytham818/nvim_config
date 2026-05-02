return {
	"folke/lazydev.nvim",
	ft = "lua", -- 仅在 lua 文件中加载
	opts = {
		library = {
			-- luvit 类型: 提供 vim.uv / vim.loop API 补全
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
			-- LuaSnip 类型 (如果你使用 luasnip 写 snippet)
			-- { path = "LuaSnip/library", words = { "require%.luasnip" } },
		},
	},
}
