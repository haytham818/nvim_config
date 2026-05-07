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
			bind_to_cwd = false,
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = true,
			},
			components = {
				arrow_status = function(config, node, state)
					local arrow_status = require("arrow.statusline")
					if arrow_status.is_on_arrow_file(node.path) then
						return {
							text = " ",
							highlight = "DiagnosticWarn",
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
				["l"] = "open", -- 用 l 打开文件
				["h"] = "close_node", -- 用 h 收起文件夹
			},
		},

		event_handlers = {
			{
				event = "file_opened",
				handler = function(file_path)
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
	},
}
