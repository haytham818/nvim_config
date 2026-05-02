return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- 确保它在其他插件之前加载，防止启动时闪烁
	config = function()
		require("onedarkpro").setup({
			-- 这里可以配置选项
			styles = {
				types = "NONE",
				methods = "bold",
				comments = "italic", -- 注释使用斜体
				keywords = "bold,italic",
				strings = "NONE",
				variables = "NONE",
			},
			-- 如果你想让背景透明（显示终端背景图），把下面设为 true
			options = {
				transparency = false,
				lualine_transparency = false,
			},
		})

		-- 立即应用主题
		vim.cmd("colorscheme onedark_vivid")
	end,
}
