return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	-- build = "make install_jsregexp", -- Windows 上如果報錯可註釋掉
	dependencies = { "rafamadriz/friendly-snippets" }, -- 必裝：現成的代碼庫
	config = function()
		-- 加載 VS Code 風格的代碼片段 (來自 friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
