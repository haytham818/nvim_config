return {
	"tris203/precognition.nvim",
	event = "VeryLazy", -- 这是一个辅助练习工具，不需要在启动时加载
	cond = not vim.g.vscode,
	opts = {
		-- 1. 初始状态
		-- 建议设为 false。当你发现自己又在疯狂按 j/k 时，手动按快捷键开启它来惩罚自己。
		startVisible = false,

		-- 2. 视觉设置
		showBlankVirtLine = true, -- 是否在空行显示提示
		highlightColor = { link = "Comment" }, -- 提示字符的颜色 (建议设为注释色，不抢眼)

		-- 3. 提示灵敏度
		-- 比如 'w' (下一个单词) 这种太简单的动作，如果你觉得太吵，可以关掉
		hints = {
			Caret = { text = "^", prio = 2 },
			Dollar = { text = "$", prio = 1 },
			MatchingPair = { text = "%", prio = 5 },
			Zero = { text = "0", prio = 1 },
			w = { text = "w", prio = 10 },
			b = { text = "b", prio = 9 },
			e = { text = "e", prio = 8 },
			W = { text = "W", prio = 7 },
			B = { text = "B", prio = 6 },
			E = { text = "E", prio = 5 },
		},

		-- 4. 这里的 gutter 指的是左侧行号旁边的提示
		gutterHints = {
			G = { text = "G", prio = 10 },
			gg = { text = "gg", prio = 20 },
			PrevParagraph = { text = "{", prio = 4 },
			NextParagraph = { text = "}", prio = 3 },
		},

		-- 5. 黑名单 (重要！)
		-- 防止在文件树、终端、仪表盘里显示乱七八糟的提示
		filetypes = {
			"NvimTree",
			"neo-tree",
			"toggleterm",
			"lazy",
			"mason",
			"TelescopePrompt",
			"alpha",
			"dashboard",
		},
	},
	keys = {
		-- 定义一个快捷键来开关
		{
			"<leader>cp", -- cp = Code Precognition
			function()
				if require("precognition").toggle() then
					vim.notify("Precognition ON")
				else
					vim.notify("Precognition OFF")
				end
			end,
			desc = "Toggle Precognition (Motion Hints)",
		},
		-- "Peek" 模式：按住某个键时才显示提示 (可选，适合偶尔看一眼)
		-- {
		--   "<leader>cP",
		--   function() require("precognition").peek() end,
		--   desc = "Peek Precognition",
		-- },
	},
}
