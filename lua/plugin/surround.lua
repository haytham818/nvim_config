-- lua/plugins/surround.lua
return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	vscode = true,
	config = function()
		require("nvim-surround").setup({})
	end,
}
