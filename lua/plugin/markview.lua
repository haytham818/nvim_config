return {
	"OXY2DEV/markview.nvim",
	ft = { "markdown", "norg", "rmd", "org" },

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

			checkboxes = {
				enable = true,
				checked = { icon = "✔" },
				unchecked = { icon = "✘" },
			},

			horizontal_rules = {
				enable = true,
				parts = {
					{ type = "repeating", text = "─", highlight = "Comment" },
				},
			},
		},
	},

	keys = {
		{ "<leader>mp", "<cmd>Markview toggle<cr>", desc = "Toggle Markdown Preview" },
	},
}
