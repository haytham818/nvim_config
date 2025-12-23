-- lua/plugins/persistence.lua
return {
	"folke/persistence.nvim",
	event = "BufReadPre",
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
