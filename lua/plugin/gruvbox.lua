return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000, -- 确保最先加载
	config = function()
		-- 1. 配置选项 (必须在 setup 裡设置，setup 必须在 colorscheme 之前)
		require("gruvbox").setup({
			-- 对比度设置： "hard", "medium"(默认), "soft"
			contrast = "hard",

			-- 是否透明背景 (透出终端背景图)
			transparent_mode = false,

			-- 细节样式
			italic = {
				strings = false,
				comments = true, -- 注释斜体
				operators = false,
				folds = true,
			},

			-- 覆盖默认颜色 (如果你觉得某些颜色不好看)
			overrides = {
				-- 例如：把行号变成黄色
				-- LineNr = { fg = "#fabd2f" },
			},
		})

		-- 2. 应用配色
		vim.cmd("colorscheme gruvbox")
	end,
}
