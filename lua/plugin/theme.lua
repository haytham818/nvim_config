local default_theme = "gruvbox"
-- 修改这里即可切换默认主题
local available_themes = {
	gruvbox = true,
	catppuccin = true,
	["gruvbox-material"] = true,
	monokai_pro = true,
	onedark_vivid = true,
}

if not available_themes[default_theme] then
	error(("unknown theme: %s"):format(default_theme))
end

local function use_theme(name)
	return default_theme == name
end

local function maybe_set_colorscheme(name)
	if use_theme(name) then
		vim.cmd.colorscheme(name)
	end
end

return {
	{
		"ellisonleao/gruvbox.nvim",
		enabled = use_theme("gruvbox"),
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = false,
				italic = {
					strings = false,
					comments = true,
					operators = false,
					folds = true,
				},
			})

			maybe_set_colorscheme("gruvbox")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = use_theme("catppuccin"),
		lazy = false,
		priority = 1000,
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

			maybe_set_colorscheme("catppuccin")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		enabled = use_theme("gruvbox-material"),
		lazy = false,
		priority = 1000,
		config = function()
			-- 'hard', 'medium', 'soft'
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_enable_italic = 1

			maybe_set_colorscheme("gruvbox-material")
		end,
	},
	{
		"tanvirtin/monokai.nvim",
		enabled = use_theme("monokai_pro"),
		lazy = false,
		priority = 1000,
		config = function()
			maybe_set_colorscheme("monokai_pro")

			-- 强制将背景设置为 "NONE" (透明)
			-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- 非当前窗口背景
			-- vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = "none" })
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		enabled = use_theme("onedark_vivid"),
		lazy = false,
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				styles = {
					types = "NONE",
					methods = "bold",
					comments = "italic",
					keywords = "bold,italic",
					strings = "NONE",
					variables = "NONE",
				},
				options = {
					transparency = false,
					lualine_transparency = false,
				},
			})

			maybe_set_colorscheme("onedark_vivid")
		end,
	},
}
