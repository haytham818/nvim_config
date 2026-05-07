return {
	"gbprod/yanky.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		highlight = {
			on_put = true,
			on_yank = true,
			timer = 200,
		},
		preserve_cursor_position = {
			enabled = true,
		},
		system_clipboard = {
			sync_with_ring = true,
		},
	},
	keys = function()
		local keys = {
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put After" },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Before" },
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

			{ "<C-n>", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Yank History" },
			{ "<C-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Yank History" },
		}

		table.insert(keys, {
			"<leader>y",
			function()
				require("telescope").extensions.yank_history.yank_history()
			end,
			desc = "Open Yank History",
		})

		return keys
	end,
}
