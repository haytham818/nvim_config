return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	config = function()
		vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left)
		vim.keymap.set("n", "<A-left>", require("smart-splits").move_cursor_left)
		vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
		vim.keymap.set("n", "<A-down>", require("smart-splits").move_cursor_down)
		vim.keymap.set("n", "<A-up>", require("smart-splits").move_cursor_up)
		vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
		vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)
		vim.keymap.set("n", "<A-right>", require("smart-splits").move_cursor_right)
	end,
}
