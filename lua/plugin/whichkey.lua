return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- 1. 延迟设置：非常重要
		-- 如果设为 0，你每次按 y 都会立刻弹窗，这会很烦。
		-- 建议设为 400-800ms，这样你熟练时直接按 yy 不会弹窗，
		-- 只有你按了 y 停顿思考时，它才会弹出来提示你。
		delay = 200,

		-- 2. 预设配置
		-- 这里决定了哪些按键会触发提示
		plugins = {
			marks = true, -- 显示标记 (比如按 ' )
			registers = true, -- 显示寄存器 (比如按 " )
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			-- 核心：开启操作符和动作的提示
			presets = {
				operators = true, -- 开启这个！按 y, d, c, > 等会显示提示
				motions = true, -- 开启这个！显示位移提示
				text_objects = true, -- 显示文本对象 (比如 da w 中的 w)
				windows = true, -- 显示窗口操作 (<c-w>)
				nav = true, -- 显示杂项跳转
				z = true, -- 显示折叠相关 (z)
				g = true, -- 显示 g 开头的命令
			},
		},

		-- 3. 界面美化 (可选，根据你的喜好)
		win = {
			border = "rounded", -- 圆角边框
			-- position = "bottom", -- 默认就在底部，类似状态栏
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
