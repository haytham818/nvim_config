return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>-",
			function()
				require("yazi").yazi()
			end,
			desc = "Open Yazi",
		},
		{
			"<leader>cw",
			function()
				require("yazi").yazi(nil, vim.fn.getcwd())
			end,
			desc = "Open Yazi in working directory",
		},
	},
	opts = {
		open_for_directories = true,
		keymaps = {
			show_help = "<f1>",
		},

		floating_window_scaling_factor = 0.9,
		yazi_floating_window_winblend = 0,

		open_multiple_tabs = false,

		highlight_groups = {
			hovering = "Visual",
		},

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
