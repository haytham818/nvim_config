return {
	"tris203/precognition.nvim",
	event = "VeryLazy",
	opts = {
		startVisible = false,

		showBlankVirtLine = true,
		highlightColor = { link = "Comment" },

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

		gutterHints = {
			G = { text = "G", prio = 10 },
			gg = { text = "gg", prio = 20 },
			PrevParagraph = { text = "{", prio = 4 },
			NextParagraph = { text = "}", prio = 3 },
		},

		filetypes = {
			"NvimTree",
			"oil",
			"toggleterm",
			"lazy",
			"mason",
			"TelescopePrompt",
			"alpha",
			"dashboard",
		},
	},
	keys = {
		{
			"<leader>cp", -- cp = Code Precognition
			function()
				if require("precognition").toggle() then
					vim.notify("Precognition ON")
				else
					vim.notify("Precognition OFF")
				end
			end,
			desc = "Toggle Precognition",
		},
		-- "Peek" 模式：按住某个键时才显示提示 (可选，适合偶尔看一眼)
		{
			"<leader>cP",
			function()
				require("precognition").peek()
			end,
			desc = "Peek Precognition",
		},
	},
}
