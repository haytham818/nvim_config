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
				"github:Crashdummyy/mason-registry",
			},
		})

		-- Mason-LSPConfig for automatic LSP server installation
		-- Works with vim.lsp.enable() in lsp.lua
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- Lua
				"clangd", -- C/C++
				-- rust_analyzer 使用 rustup 自带版本，Mason 版本与 Cargo 1.95 不兼容 (--lockfile-path)
				"taplo", -- TOML
				"pyright", -- Python
			},
			automatic_installation = true,
		})
	end,
}
