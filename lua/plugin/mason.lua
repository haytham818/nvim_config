return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			registries = {
				"github:mason-org/mason-registry",
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- Lua
				"clangd", -- C/C++
				"taplo", -- TOML
				"pyright", -- Python
			},
			automatic_enable = false,
		})
	end,
}
