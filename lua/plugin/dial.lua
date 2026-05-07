return {
	"monaqa/dial.nvim",
	-- 懒加载：只有当按下以下按键时才加载插件
	keys = {
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			mode = "n",
			desc = "Increment",
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("decrement", "normal")
			end,
			mode = "n",
			desc = "Decrement",
		},
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gnormal")
			end,
			mode = "n",
			desc = "Increment (G)",
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gnormal")
			end,
			mode = "n",
			desc = "Decrement (G)",
		},
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "visual")
			end,
			mode = "v",
			desc = "Increment",
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("decrement", "visual")
			end,
			mode = "v",
			desc = "Decrement",
		},
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gvisual")
			end,
			mode = "v",
			desc = "Increment (G)",
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gvisual")
			end,
			mode = "v",
			desc = "Decrement (G)",
		},
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			-- 默认组：这里定义了你想支持哪些类型的转换
			default = {
				-- 1. 基础数字
				augend.integer.alias.decimal, -- 十进制 (0, 1, 2...)
				augend.integer.alias.hex, -- 十六进制 (0x1f, 0xa...)

				-- 2. 日期和时间 (非常实用)
				augend.date.alias["%Y/%m/%d"], -- 2025/12/09
				augend.date.alias["%Y-%m-%d"], -- 2023-12-23
				augend.date.alias["%H:%M"], -- 15:22

				-- 3. 编程逻辑常量
				augend.constant.alias.bool, -- false <-> true

				-- 4. 逻辑运算符
				augend.constant.new({
					elements = { "||", "&&" },
					word = false,
					cyclic = true,
				}),

				-- 5. 变量声明关键字
				augend.constant.new({
					elements = { "let", "const" },
					word = true,
					cyclic = true,
				}),

				-- 6. 颜色
				augend.hexcolor.new({
					case = "lower",
				}),

				-- 7. 大小写转换
				augend.case.new({
					types = { "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
					cyclic = true,
				}),
			},
		})
	end,
}
