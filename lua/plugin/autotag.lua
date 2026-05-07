return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" }, -- 打开文件时加载
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- 自动闭合标签
				enable_rename = true, -- 自动重命名标签
				enable_close_on_slash = false, -- 输入 </ 时自动闭合
			},
		})
	end,
}
