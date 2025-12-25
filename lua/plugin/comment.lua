return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	vscode = true,
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring", -- 依赖这个插件来判断上下文
	},
	config = function()
		-- 安全加载 context-commentstring
		local pre_hook = nil
		local status, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
		if status then
			pre_hook = ts_context.create_pre_hook()
		end

		require("Comment").setup({
			-- 关键：根据光标所在的位置（JS区域还是HTML区域）决定使用什么注释符号
			pre_hook = pre_hook,

			-- 基础映射配置 (保持默认即可，为了让你了解我列出来了)
			toggler = {
				line = "gcc", -- 行注释
				block = "gbc", -- 块注释
			},
			opleader = {
				line = "gc", -- 配合动作，如 gc2j (注释下两行)
				block = "gb", -- 配合动作
			},
		})
	end,
}
