return {
	"noir4y/comment-translate.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("comment-translate").setup({
			target_language = "zh",
			translate_service = "llm",

			hover = {
				enabled = false,
				delay = 500,
				auto = true,
			},

			immersive = {
				enabled = false,
			},

			cache = {
				enabled = true,
				max_entries = 1000,
			},

			targets = {
				string = true,
				comment = true,
			},

			llm = {
				provider = "openai",
				model = "deepseek-v4-flash",
				api_key = vim.env.DEEPSEEK_API_KEY,
				endpoint = "https://api.deepseek.com/chat/completions",
			},

			keymaps = {
				hover = "<leader>tf",
				hover_manual = "<leader>tc",
				replace = "<leader>tr",
				toggle = "<leader>tt",
			},
		})
	end,
}
