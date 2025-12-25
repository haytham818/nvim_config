return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy", -- 懒加载，当你进入 UI 后加载
	lazy = false,

	-- 1. 定义快捷键：这里设置了最常用的 Tab 切换和关闭操作
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
			-- 2. 风格配置
			mode = "buffers", -- 设置为 buffer 模式 (也有 tabs 模式，但一般用 buffers)
			-- 分隔符风格: "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
			separator_style = "thin", -- 推荐 "slant" 或 "slope"，看起来比较现代

			-- 3. LSP 诊断集成：标签页上显示错误图标
			diagnostics = "nvim_lsp",
			always_show_bufferline = false, -- 只有一个 buffer 时是否隐藏 (true 为始终显示)

			-- 自定义诊断信息的显示格式
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
				-- 如果你用的是 NvimTree，取消下面注释并注释掉上面
				-- {
				--   filetype = "nvim-tree",
				--   text = "File Explorer",
				--   highlight = "Directory",
				--   text_align = "left",
				-- },
			},

			-- 5. 交互行为
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
			-- 左侧显示的图标 (比如让被修改的文件显示一个圆点)
			show_buffer_close_icons = true,
			show_close_icon = true,
		},
	},
}
