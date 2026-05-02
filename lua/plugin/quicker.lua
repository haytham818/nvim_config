return {
	"stevearc/quicker.nvim",
	event = "FileType qf", -- 只有打开 Quickfix 窗口时才加载，极致优化

	-- 全局快捷键：用于快速打开/关闭 Quickfix
	keys = {
		{
			"<leader>q",
			function()
				require("quicker").toggle()
			end,
			desc = "Toggle Quickfix",
		},
		{
			"<leader>l",
			function()
				require("quicker").toggle({ loclist = true })
			end,
			desc = "Toggle Loclist",
		},
	},

	opts = {
		-- 1. 自动聚焦 (可选)
		-- 打开 Quickfix 时自动把光标移过去
		-- on_qf_open = function(bufnr)
		--   vim.api.nvim_set_current_buf(bufnr)
		-- end,

		-- 2. 快捷键设置 (只在 Quickfix 窗口内生效)
		keys = {
			{ ">", "expand", desc = "Expand context" }, -- 展开显示更多上下文
			{ "<", "collapse", desc = "Collapse context" }, -- 折叠
		},

		-- 3. 编辑功能 (最强功能)
		edit = {
			enabled = true,
			autosave = "unmodified", -- 当你在 Quickfix 里 :w 保存时，自动写入到对应文件
		},

		-- 4. 视觉优化
		borders = {
			vert = "│", -- 简单的竖线分隔
			horz = "─",
		},

		-- 显示行号列，对齐更整齐
		constrain_cursor = true,
	},
}
