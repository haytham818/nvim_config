---@brief
---
--- https://github.com/haskell/haskell-language-server
---
--- Haskell Language Server
---
--- If you are using HLS 1.9.0.0, enable the language server to launch on Cabal files as well:
---
--- ```lua
--- vim.lsp.config('hls', {
---   filetypes = { 'haskell', 'lhaskell', 'cabal' },
--- })
--- ```

local util = require("lspconfig.util")

---@type vim.lsp.Config
return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	filetypes = { "haskell", "lhaskell" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root = util.root_pattern("hie.yaml", "cabal.project", "stack.yaml")(fname)
			or util.root_pattern("*.cabal", "package.yaml")(fname)
			or vim.fs.dirname(fname)
			or vim.uv.cwd()

		on_dir(root)
	end,
	settings = {
		haskell = {
			formattingProvider = "fourmolu",
			cabalFormattingProvider = "cabal-fmt",
		},
	},
}
