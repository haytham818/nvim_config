return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000, -- 确保最先加载
	config = function()
		require("gruvbox").setup({
			contrast = "hard",

			transparent_mode = false,

			italic = {
				strings = false,
				comments = true, -- 注释斜体
				operators = false,
				folds = true,
			},
		})

		vim.cmd("colorscheme gruvbox")
	end,
}
