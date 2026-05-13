return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",

	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "固定/取消固定当前标签" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "关闭非固定标签" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "关闭其他标签" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "关闭右侧标签" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "关闭左侧标签" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "切换到左侧标签" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "切换到右侧标签" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "切换到左侧标签" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "切换到右侧标签" },
	},

	opts = {
		options = {
			mode = "buffers",
			separator_style = "thin",

			diagnostics = "nvim_lsp",

			always_show_bufferline = false,

			diagnostics_indicator = function(count, level, _, _)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,

			offsets = {
				{
					filetype = "minifiles",
					text = "MiniFiles",
					highlight = "Directory",
					text_align = "left",
				},
			},

			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
			show_buffer_close_icons = true,
			show_close_icon = true,
		},
	},
}
