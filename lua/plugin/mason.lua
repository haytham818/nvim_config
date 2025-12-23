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
		})

		-- Mason-LSPConfig for automatic LSP server installation
		-- Works with vim.lsp.enable() in lsp.lua
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- Lua
				"clangd", -- C/C++
				"rust_analyzer", -- Rust
				"taplo", -- TOML
				"pyright", -- Python
			},
			automatic_installation = true,
		})
	end,
}
