return {
	"olimorris/onedarkpro.nvim",
	priority = 1000,
	config = function()
		require("onedarkpro").setup({
			-- 这里可以配置选项
			styles = {
				types = "NONE",
				methods = "bold",
				comments = "italic",
				keywords = "bold,italic",
				strings = "NONE",
				variables = "NONE",
			},
			options = {
				transparency = false,
				lualine_transparency = false,
			},
		})

		-- 立即应用主题
		vim.cmd("colorscheme onedark_vivid")
	end,
}
