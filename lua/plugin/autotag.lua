return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" }, -- 打开文件时加载
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- 强依赖 Treesitter
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- 自动闭合标签
				enable_rename = true, -- 自动重命名标签 (极其好用！)
				enable_close_on_slash = false, -- 输入 </ 时自动闭合 (有了上面那个，这个其实不太需要)

			},
			-- 如果你需要针对特定文件类型微调 (一般默认即可)
			-- per_filetype = {
			--   ["html"] = {
			--     enable_close = true
			--   }
			-- }
		})
	end,
}
