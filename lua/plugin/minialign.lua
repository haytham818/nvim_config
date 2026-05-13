-- lua/plugins/minialign.lua
return {
	"echasnovski/mini.align",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("mini.align").setup({})
	end,
}
