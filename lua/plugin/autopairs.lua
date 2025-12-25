return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	cond = not vim.g.vscode,
	opts = {
		map_cr = true,
	}, -- 使用默认配置即可
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
		})
	end,
}
