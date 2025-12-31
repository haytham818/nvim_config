return {
	"gbprod/yanky.nvim",
	event = { "BufReadPost", "BufNewFile" },
	vscode = true,
	opts = {
		-- 1. 视觉反馈：复制或粘贴时高亮文本
		highlight = {
			on_put = true,
			on_yank = true,
			timer = 200,
		},
		-- 2. 核心功能：复制后光标不乱跑
		-- 原生 Vim 复制一段文本后，光标会跳到文本开头或结尾
		-- 开启这个后，光标会停留在你发起复制的位置，非常符合直觉
		preserve_cursor_position = {
			enabled = true,
		},
		-- 3. 系统剪贴板同步
		system_clipboard = {
			sync_with_ring = true,
		},
	},
	keys = function()
		local keys = {
			---------------------------------------------------------
			-- 1. 替换原生粘贴键 (必须配置，否则无法循环)
			---------------------------------------------------------
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put After" },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Before" },
			-- gp 和 gP 会在粘贴后把光标移到文本后面，方便连续输入
			{
				"gp",
				"<Plug>(YankyGPutAfter)",
				mode = { "n", "x" },
				desc = "Put After (Cursor After)",
			},
			{
				"gP",
				"<Plug>(YankyGPutBefore)",
				mode = { "n", "x" },
				desc = "Put Before (Cursor After)",
			},

			---------------------------------------------------------
			-- 2. 剪贴板历史循环 (核心玩法)
			---------------------------------------------------------
			-- 粘贴后，按 Ctrl-n 或 Ctrl-p 切换刚才复制过的其他内容
			{ "<C-n>", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Yank History" },
			{ "<C-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Yank History" },
		}

		---------------------------------------------------------
		-- 3. Telescope 集成 (查找剪贴板历史) - 仅在非 VSCode 环境
		---------------------------------------------------------
		if not vim.g.vscode then
			table.insert(keys, {
				"<leader>y",
				function()
					require("telescope").extensions.yank_history.yank_history()
				end,
				desc = "Open Yank History",
			})
		end

		return keys
	end,
}
