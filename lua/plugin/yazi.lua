return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	cond = not vim.g.vscode,
	keys = {
		-- 👇 核心快捷键：打开 Yazi
		{
			"<leader>-",
			function()
				require("yazi").yazi()
			end,
			desc = "Open Yazi",
		},
		-- 👇 可选：在当前文件所在的目录打开 Yazi
		{
			"<leader>cw",
			function()
				require("yazi").yazi(nil, vim.fn.getcwd())
			end,
			desc = "Open Yazi in working directory",
		},
	},
	opts = {
		-- 1. 窗口样式配置
		open_for_directories = true, -- 当用 nvim 打开一个目录时（如 nvim .），自动用 yazi 代替 netrw
		keymaps = {
			show_help = "<f1>",
		},

		-- 2. 浮动窗口设置
		floating_window_scaling_factor = 0.9, -- 窗口大小比例 (0-1)
		yazi_floating_window_winblend = 0, -- 窗口透明度 (0为不透明，100为全透明)

		-- 3. Yazi 退出时的行为
		-- 当你在 Yazi 里退出时，Neovim 是否要根据 Yazi 的选择打开文件
		-- 默认为 true，如果你只想用 Yazi 改目录而不打开文件，可以设为 false
		open_multiple_tabs = false,

		-- 4. 高亮支持 (可选)
		-- 如果你想让 Yazi 窗口里的文本也支持高亮
		highlight_groups = {
			hovering = "Visual",
		},

		-- 5. 整合功能
		-- 如果你用的是 telescope，可以开启这个集成
		integrations = {
			grep_in_directory = function(directory)
				require("telescope.builtin").live_grep({ cwd = directory })
			end,
			grep_in_selected_files = function(selected_files)
				require("telescope.builtin").live_grep({ search_dirs = selected_files })
			end,
		},
	},
}
