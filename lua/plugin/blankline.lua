return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },

	---@module "ibl"
	---@type ibl.config
	opts = {
		-- 缩进
		indent = {
			char = "│",
			tab_char = "│",
			highlight = "IblIndent",
			smart_indent_cap = true,
		},

		scope = {
			enabled = true,
			show_start = true,
			show_end = false,
			highlight = "IblScope",
		},

		whitespace = {
			highlight = "IblWhiteSpace",
			remove_blankline_trail = true,
		},

		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"minifiles",
				"minifiles-help",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"lazyterm",
			},
		},
	},
}
