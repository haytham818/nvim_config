return {
	"smjonas/inc-rename.nvim",
	config = function()
		require("inc_rename").setup({
			-- 可選配置：預覽時高亮變更處的背景色
			hl_group = "Substitute",
		})
	end,
	-- 配置快捷鍵
	keys = {
		{
			"<leader>rn",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true, -- 重要：必須開啟 expr，因為這個函數返回的是一個命令字符串
			desc = "LSP Incremental Rename",
		},
		{
			"<F2>",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true, -- 重要：必須開啟 expr，因為這個函數返回的是一個命令字符串
			desc = "LSP Incremental Rename",
		},
	},
}
