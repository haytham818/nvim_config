-- lua/plugins/persistence.lua
return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	cond = not vim.g.vscode,
	opts = {},
	-- 快捷键
	keys = {
		{
			"<leader>rs",
			function()
				require("persistence").load()
			end,
			desc = "Restore Session",
		},
	},
}
