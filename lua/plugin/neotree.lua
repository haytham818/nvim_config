return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		-- 推荐快捷键：<leader>e 开关文件树
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
	},
	opts = {
		-- 1. 基础 UI 配置
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,

		-- 2. 文件系统配置
		filesystem = {
			bind_to_cwd = false, -- true: 随工作目录变化; false: 随当前文件变化 (推荐 false)
			follow_current_file = {
				enabled = true, -- 打开文件时，自动在树中定位到该文件
				leave_dirs_open = false, -- 自动关闭不相关的文件夹 (保持整洁)
			},
			use_libuv_file_watcher = true, -- 文件变动时自动刷新 (非常重要!)
			filtered_items = {
				visible = true, -- 是否显示隐藏文件 (默认灰度显示)
				hide_dotfiles = false,
				hide_gitignored = true,
			},
			components = {
				arrow_status = function(config, node, state)
					local arrow_status = require("arrow.statusline")
					-- 检查当前节点路径是否在 arrow 列表中
					if arrow_status.is_on_arrow_file(node.path) then
						return {
							text = " ", -- 你可以换成 "🏹" 或 "★"
							highlight = "DiagnosticWarn", -- 使用黄色或你喜欢的颜色组
						}
					end
					return {}
				end,
			},
			renderers = {
				file = {
					{ "indent" },
					{ "icon" },
					{
						"container",
						content = {
							{ "name", zindex = 10 },
							-- 🔥 把我们的自定义组件放在文件名后面
							{ "arrow_status", zindex = 10 },
							{ "clipboard", zindex = 10 },
							{ "bufnr", zindex = 10 },
							{ "modified", zindex = 20 },
							{ "diagnostics", zindex = 20 },
							{ "git_status", zindex = 20 },
						},
					},
				},
			},
		},

		-- 3. 窗口行为配置
		window = {
			position = "left",
			width = 30,
			mappings = {
				["<space>"] = "none", -- 解除空格键映射，防止冲突
				["l"] = "open", -- 用 l 打开文件 (符合 vim 方向键习惯)
				["h"] = "close_node", -- 用 h 收起文件夹
			},
		},

		-- 4. 事件处理 (解决常见痛点)
		event_handlers = {
			-- 打开文件后自动关闭 Neo-tree (可选，如果你喜欢像 VS Code 那样常驻，请注释掉这段)
			{
				event = "file_opened",
				handler = function(file_path)
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
	},
}
