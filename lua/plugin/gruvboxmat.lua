return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		-- 风格：'hard', 'medium', 'soft'
		vim.g.gruvbox_material_background = "hard"

		-- 更好的性能
		vim.g.gruvbox_material_better_performance = 1

		-- 启用斜体
		vim.g.gruvbox_material_enable_italic = 1

		-- 应用配色
		vim.cmd("colorscheme gruvbox-material")
	end,
}
