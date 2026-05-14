local function open_command_palette()
	require("telescope.builtin").commands()
end

local function open_command_history()
	require("telescope.builtin").command_history()
end

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
		{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Telescope projects" },
		{ "<leader>:", open_command_palette, desc = "Command palette" },
		{ "<leader>f:", open_command_history, desc = "Command history" },
		{ "<M-x>", open_command_palette, desc = "Command palette" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				file_ignore_patterns = { "node_modules", ".git" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.87,
					height = 0.80,
				},
				sorting_strategy = "ascending",
			},
			pickers = {
				commands = {
					theme = "ivy",
					previewer = false,
					initial_mode = "insert",
					show_buf_command = true,
					layout_config = {
						height = 0.35,
					},
				},
				command_history = {
					theme = "ivy",
					previewer = false,
					initial_mode = "insert",
					layout_config = {
						height = 0.25,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						previewer = true,
					}),
				},
				fzf = {},
				projects = {},
			},
		})

		telescope.load_extension("ui-select")
		telescope.load_extension("fzf")
		telescope.load_extension("projects")
	end,
}
