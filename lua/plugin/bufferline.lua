return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",

	-- 快捷键
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
			-- 分隔符: "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
			separator_style = "thin",

			-- LSP
			diagnostics = "nvim_lsp",

			always_show_bufferline = false,

			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,

			-- 4. 侧边栏偏移配置 (非常重要！)
			-- 这里的 filetype 填你的文件树插件，如 "neo-tree" 或 "nvimtree"
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neo-tree", -- 侧边栏上方显示的文字
					highlight = "Directory",
					text_align = "left",
				},
			},

			-- 5. 交互行为
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
