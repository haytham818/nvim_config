return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
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
		})

		-- Mason-LSPConfig integration for automatic LSP server installation
		require("mason-lspconfig").setup({
			-- Automatically install these LSP servers
			ensure_installed = {
				"lua_ls", -- Lua
				"clangd", -- C/C++
				"rust_analyzer", -- Rust
				"taplo", -- TOML
				"pyright", -- Python
			},
			-- Automatically install LSP servers configured with lspconfig
			automatic_installation = true,
		})
	end,
}
