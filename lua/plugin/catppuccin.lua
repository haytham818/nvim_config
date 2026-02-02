return {
	"catppuccin/nvim",
	cond = not vim.g.vscode,
	name = "catppuccin",
	priority = 1000, -- 确保最先加载
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- 是否透明背景
			show_end_of_buffer = false, -- 是否显示文件末尾的 '~'
			term_colors = true, -- 设置终端颜色 (例如 :terminal)
			dim_inactive = {
				enabled = false, -- 是否调暗非活动窗口
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false, -- 强制不使用斜体
			no_bold = false, -- 强制不使用粗体
			no_underline = false, -- 强制不使用下划线
			styles = { -- 定义语法高亮样式
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = {},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				-- 针对你已安装插件的集成
				neotree = true,
				telescope = true,
				mason = true,
				which_key = true,
				indent_blankline = {
					enabled = true,
					scope_color = "", -- 默认为 catppuccin 的颜色
					colored_indent_levels = false,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
		})

		-- 设置配色方案
		vim.cmd.colorscheme("catppuccin")
	end,
}
