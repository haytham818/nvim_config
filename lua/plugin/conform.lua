return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },

	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({
					lsp_format = "fallback",
					async = true,
					timeout_ms = 3000,
				})
			end,
			mode = { "n", "v" },
			desc = "Format current buffer",
		},
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			toml = { "taplo" },
			cs = { "csharpier" },
			rust = { "rustfmt", lsp_format = "fallback" },
			zig = { "zigfmt" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			python = { "isort", "black" },
		},

		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			return {
				timeout_ms = 3000,
				lsp_format = "fallback",
				async = false,
			}
		end,

		formatters = {
			["clang-format"] = {
				prepend_args = { "--style=file", "--fallback-style=Microsoft" },
			},
		},
	},

	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
