-- lua/plugins/minialign.lua
return {
	"echasnovski/mini.align",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("mini.align").setup({
			-- 默认映射 ga = 对齐, gA = 预览对齐
		})
	end,
}
