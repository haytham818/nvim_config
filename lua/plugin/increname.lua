return {
	"smjonas/inc-rename.nvim",
	config = function()
		require("inc_rename").setup({
			hl_group = "Substitute",
		})
	end,
	keys = {
		{
			"<leader>rn",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true,
			desc = "LSP Incremental Rename",
		},
		{
			"<F2>",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true,
			desc = "LSP Incremental Rename",
		},
	},
}
