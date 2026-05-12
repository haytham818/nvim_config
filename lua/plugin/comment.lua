return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local pre_hook = nil
		local status, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
		if status then
			pre_hook = ts_context.create_pre_hook()
		end

		require("Comment").setup({
			pre_hook = pre_hook,

			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
		})
	end,
}
