return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- 必须安装图标字体
		"folke/noice.nvim", -- 确保 noice 在 lualine 之前加载（状态栏集成）
	},
	event = "VeryLazy", -- 懒加载，不需要启动时立即加载
	opts = function(_, opts)
		-- 获取 noice 的状态接口（如果未安装 noice，则不报错）
		local noice_ok, noice = pcall(require, "noice")

		return {
			options = {
				theme = "auto", -- 自动跟随你的 colorscheme (如 tokyonight, catppuccin)
				globalstatus = true, -- 强烈推荐：使用全局状态栏（底部只有一条，而不是每个窗口一条）
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" }, -- 使用圆角分隔符 (需要 Nerd Font)
			},

			sections = {
				-- 左侧部分
				lualine_a = {
					{ "mode", separator = { left = "" }, right_padding = 2 },
				},
				lualine_b = {
					"branch", -- Git 分支
					"diff", -- Git 差异
					"diagnostics", -- LSP 诊断信息 (错误、警告数量)
				},
				lualine_c = {
					{
						function()
							-- 安全调用，防止报错
							local status_ok, arrow_status = pcall(require, "arrow.statusline")
							if not status_ok then
								return "hachimi"
							end
							return arrow_status.text_for_statusline()
						end,
						-- 决定何时显示
						cond = function()
							local status_ok, arrow_status = pcall(require, "arrow.statusline")
							-- 1. 插件必须加载成功
							-- 2. 当前文件必须已经被标记 (is_on_arrow_file)
							return status_ok and arrow_status.is_on_arrow_file()
						end,
						color = { fg = "#ff9e64", gui = "bold" },
					},
					"filename", -- 文件名
				},

				-- 右侧部分
				lualine_x = {
					-- Noice 集成：显示“正在录制宏” (Recording @q)
					-- 因为 Noice 隐藏了命令行，这个配置非常重要！
					{
						function()
							return noice.api.status.mode.get()
						end,
						cond = function()
							return noice_ok and noice.api.status.mode.has()
						end,
						color = { fg = "#ff9e64" }, -- 橙色提示
					},
					-- Noice 集成：显示搜索计数 (比如 [1/10])
					{
						function()
							return noice.api.status.search.get()
						end,
						cond = function()
							return noice_ok and noice.api.status.search.has()
						end,
						color = { fg = "#ff9e64" },
					},
					{
						function()
							return noice.api.status.command.get()
						end,
						cond = function()
							return noice_ok and noice.api.status.command.has()
						end,
						color = { fg = "#ff9e46" },
					},
					"encoding", -- 文件编码 (utf-8)
					"fileformat", -- 系统格式 (unix/dos)
					"filetype", -- 文件类型 (lua, python...)
				},
				lualine_y = {
					"progress", -- 进度百分比
				},
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 }, -- 当前光标位置 (行:列)
				},
			},
			extensions = { "neo-tree", "lazy" }, -- 自动支持特定窗口的样式
		}
	end,
}
