return {
	"folke/noice.nvim",
	event = "VeryLazy",
	cond = not vim.g.vscode,
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	opts = {
		-- 1. LSP 配置：让 Noice 接管 LSP 的显示
		lsp = {
			-- 覆盖默认的 lsp 处理
			override = {
				-- 使用 Noice 的浮动窗口显示 vim.lsp.util.convert_input_to_markdown_lines
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				-- 使用 Noice 的浮动窗口显示 vim.lsp.util.stylize_markdown
				["vim.lsp.util.stylize_markdown"] = true,
				-- 使用 Noice 的浮动窗口显示 cmp 的文档 (如果你用了 nvim-cmp)
				-- ["cmp.entry.get_documentation"] = true,
			},
			-- 悬浮文档和签名帮助的配置
			hover = {
				enabled = true,
				silent = true,
			},
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true, -- 输入参数时自动弹出
					luasnip = true,
					throttle = 50, -- 防抖动，单位ms
				},
			},
		},

		presets = {
			bottom_search = true, -- 将搜索栏也就是 cmdline 放在底部 (类似默认 vim，但更好看)
			command_palette = true, -- 将 cmdline 居中（类似 VS Code 的命令面板），设置为 false 则在底部
			long_message_to_split = true, -- 长消息（如报错）自动发送到 split 窗口，防止遮挡
			inc_rename = true, -- 如果你安装了 inc-rename.nvim 插件，设为 true
			lsp_doc_border = true, -- 为 LSP 文档添加边框 (Noice 默认已有漂亮边框，通常设为 false)
		},

		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written", -- 过滤掉保存文件时 "written" 的消息
				},
				opts = { skip = true },
			},
		},

		-- 4. 视图配置
		views = {
			-- 这里可以定制特定窗口的样式，例如 cmdline_popup
		},
	},
}
