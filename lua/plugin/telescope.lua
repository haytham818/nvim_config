return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
		-- FZF native for better performance
		-- {
		-- 	"nvim-telescope/telescope-fzf-native.nvim",
		-- 	build = "make",
		-- },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		-- 设置快捷键 (这是最常用的映射)

		-- <leader>ff : Find Files (找文件)

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })

		-- <leader>fg : Live Grep (全局搜关键字 - 需要 ripgrep)

		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })

		-- <leader>fb : Find Buffers (在打开的文件之间切换)

		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })

		-- <leader>fh : Help Tags (搜帮助文档)

		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

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
				-- fzf = {
				-- 	fuzzy = true, -- false will only do exact matching
				-- 	override_generic_sorter = true, -- override the generic sorter
				-- 	override_file_sorter = true, -- override the file sorter
				-- 	case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- },
			},
		})

		-- 3. 關鍵步驟：加載擴充功能
		-- 必須在 setup() 之後調用
		telescope.load_extension("ui-select")
		-- telescope.load_extension("fzf")
	end,
}
