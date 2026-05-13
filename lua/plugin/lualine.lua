return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/noice.nvim",
	},
	event = "VeryLazy",
	opts = function(_, opts)
		local noice_ok, noice = pcall(require, "noice")

		return {
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},

			sections = {
				lualine_a = {
					{ "mode", separator = { left = "" }, right_padding = 2 },
				},
				lualine_b = {
					"branch",
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{
						function()
							local status_ok, arrow_status = pcall(require, "arrow.statusline")
							if not status_ok then
								return "hachimi"
							end
							return arrow_status.text_for_statusline()
						end,
						cond = function()
							local status_ok, arrow_status = pcall(require, "arrow.statusline")
							return status_ok and arrow_status.is_on_arrow_file()
						end,
						color = { fg = "#ff9e64", gui = "bold" },
					},
					"filename",
				},

				-- 右侧部分
				lualine_x = {
					{
						function()
							return noice.api.status.mode.get()
						end,
						cond = function()
							return noice_ok and noice.api.status.mode.has()
						end,
						color = { fg = "#ff9e64" },
					},
					{
						function()
							return noice.api.status.search.get()
						end,
						cond = function()
							return noice_ok and noice.api.status.search.has()
						end,
						color = { fg = "#ff9e64" },
					},
					{
						function()
							return noice.api.status.command.get()
						end,
						cond = function()
							return noice_ok and noice.api.status.command.has()
						end,
						color = { fg = "#ff9e46" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {
					"progress",
				},
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
			},
			extensions = { "lazy" },
		}
	end,
}
