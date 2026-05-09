return {
	"NeogitOrg/neogit",
	lazy = true,
	cmd = "Neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>lg", "<cmd>Neogit<cr>", desc = "Neogit" },
	},
	opts = {
		integrations = {
			diffview = true,
			telescope = true,
		},
	},
}
