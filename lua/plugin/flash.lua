-- lua/plugins/flash.lua
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	vscode = true,
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
	},
}
