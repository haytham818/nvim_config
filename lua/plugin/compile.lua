return {
	"ej-shafran/compile-mode.nvim",
	version = "^5.0.0",
	branch = "latest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	config = function()
		---@type CompileModeOpts
		vim.g.compilemode = {
			input_word_completion    = true,
			baleia                   = true,
			bang_expansion           = true,
			baleia_setup             = true,
			auto_jump_to_first_error = true,
			use_diagnostics          = false,
		}
	end,
}
