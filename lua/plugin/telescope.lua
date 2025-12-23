return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
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

		-- 3. 關鍵步驟：加載擴充功能
		-- 必須在 setup() 之後調用
		telescope.load_extension("ui-select")
	end,
}
