return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- 1. 缩进线
		indent = {
			char = "│", --  "▏" OR "┆")
			tab_char = "│",
		},

		-- 2. 当前作用域高亮
		scope = {
			enabled = true,
			show_start = false, -- 是否显示作用域顶部的横线
			show_end = false, -- 是否显示作用域底部的横线
		},

		-- 3. 排除配置
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"oil",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
		},
	},
}
