return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				-- 你的其他預設配置...
				file_ignore_patterns = { "node_modules", ".git" },
				-- Better performance
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
				-- Better layout
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
			-- 2. 在這裡配置擴充功能
			extensions = {
				["ui-select"] = {
					-- 使用下拉選單主題 (cursor, dropdown, ivy)
					-- 這是最像 IDE 的風格
					require("telescope.themes").get_dropdown({
						-- 你可以在這裡自定義寬度等參數
						-- width = 0.8,
						-- previewer = false,
						previewer = true,
					}),
				},

			},
		})

		-- 3. 關鍵步驟：加載擴充功能（必須在 setup() 之後調用）
		telescope.load_extension("ui-select")
	end,
}
