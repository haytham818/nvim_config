return {
	"OXY2DEV/markview.nvim",
	-- lazy = false, -- 建议不懒加载，或者仅对 markdown 文件加载
	ft = { "markdown", "norg", "rmd", "org" }, -- 如果你想懒加载，用这个

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		-- 1. 预览模式配置
		preview = {
			-- 在这些模式下开启“混合预览”
			-- "n" (Normal): 默认渲染，光标所在行显示源码
			-- "i" (Insert): 插入模式通常显示源码
			modes = { "n", "no", "c" },

			-- 混合模式：当光标移到该行时，暂时显示源码，移开后渲染
			hybrid_modes = { "n" },

			-- 回调函数：当模式切换时触发 (通常不需要动)
			callbacks = {
				on_enable = function(_, win)
					-- 开启时强制设置 conceallevel，否则预览不生效
					vim.wo[win].conceallevel = 2
					vim.wo[win].concealcursor = "nc"
				end,
			},
		},

		-- 2. Markdown 元素渲染配置 (按需修改)
		markdown = {
			-- 标题配置
			headings = {
				enable = true,
				shift_width = 0, -- 标题是否缩进
				heading_1 = { style = "icon", icon = "󰉫 " }, -- H1 图标
				heading_2 = { style = "icon", icon = "󰉬 " },
				-- 你也可以用 "label" 风格，背景色块那种
			},

			-- 代码块
			code_blocks = {
				enable = true,
				style = "language", -- 显示语言名称
				pad_amount = 2, -- 代码块内边距
			},

			-- 表格 (这是 Markview 最强的地方，自动对齐且美观)
			tables = {
				enable = true,
				block_decorator = true,
				use_virt_lines = true,
			},

			-- 复选框 [ ] [x]
			checkboxes = {
				enable = true,
				-- 自定义图标
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
