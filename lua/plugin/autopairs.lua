return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		map_cr = true,
	}, -- 默认配置
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
		})
	end,
}
