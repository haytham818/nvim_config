return {
	"OXY2DEV/markview.nvim",
	ft = { "markdown", "norg", "rmd", "org" }, -- 如果你想懒加载，用这个

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		preview = {
			modes = { "n", "no", "c" },

			hybrid_modes = { "n" },

			callbacks = {
				on_enable = function(_, win)
					vim.wo[win].conceallevel = 2
					vim.wo[win].concealcursor = "nc"
				end,
			},
		},

		markdown = {
			headings = {
				enable = true,
				shift_width = 0,
				heading_1 = { style = "icon", icon = "󰉫 " },
				heading_2 = { style = "icon", icon = "󰉬 " },
			},

			code_blocks = {
				enable = true,
				style = "language",
				pad_amount = 2,
			},

			tables = {
				enable = true,
				block_decorator = true,
				use_virt_lines = true,
			},

			-- 复选框 [✔] [✘]
			checkboxes = {
				enable = true,
				checked = { icon = "✔" },
				unchecked = { icon = "✘" },
			},

			-- 水平分割线 ---
			horizontal_rules = {
				enable = true,
				parts = {
					{ type = "repeating", text = "─", highlight = "Comment" },
				},
			},
		},
	},

	-- 配置快捷键
	keys = {
		{ "<leader>mp", "<cmd>Markview toggle<cr>", desc = "Toggle Markdown Preview" },
	},
}
