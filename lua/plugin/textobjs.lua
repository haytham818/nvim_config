return {
	"chrisgrieser/nvim-various-textobjs",
	lazy = true,
	-- 只有当用户按下以下快捷键时，插件才会被加载
	keys = {
		-- 1. 缩进 (Indentation) - 写 Python/Lua/YAML 必用
		-- ii: 选中当前缩进层级的内容 (不包含上下空行)
		-- ai: 选中当前缩进层级 + 上下关系行
		{
			"ii",
			function()
				require("various-textobjs").indentation("inner", "inner")
			end,
			mode = { "o", "x" },
			desc = "Inner Indentation",
		},
		{
			"ai",
			function()
				require("various-textobjs").indentation("outer", "inner")
			end,
			mode = { "o", "x" },
			desc = "Outer Indentation",
		},

		-- 2. 整个缓冲区 (Entire Buffer) - 比 ggVG 更快
		-- g: 选中整个文件
		-- 用法: dg (清空文件), yg (复制全文件), =g (格式化全文件)
		{
			"gG",
			function()
				require("various-textobjs").entireBuffer()
			end,
			mode = { "o", "x" },
			desc = "Entire Buffer",
		},

		-- 3. 子单词 (Subword) - 针对 camelCase 或 snake_case
		-- S: 选中驼峰命名的其中一部分
		-- 例子: myVariableName -> 选中 Variable
		{
			"S",
			function()
				require("various-textobjs").subword("inner")
			end,
			mode = { "o", "x" },
			desc = "Inner Subword",
		},

		-- 4. URL 链接
		-- L: 选中光标下的 URL
		-- 用法: dL (删除链接), cL (修改链接)
		-- "https://www.test.com/path"
		{
			"L",
			function()
				require("various-textobjs").url()
			end,
			mode = { "o", "x" },
			desc = "Link / URL",
		},

		-- 5. 诊断信息 (Diagnostics)
		-- !: 选中当前报错的区域
		-- 用法: c! (修改报错的地方)
		{
			"!",
			function()
				require("various-textobjs").diagnostic()
			end,
			mode = { "o", "x" },
			desc = "Diagnostic Scope",
		},

		-- 6. 可见区域 (Visible on screen)
		-- V: 选中屏幕上能看到的所有内容
		{
			"V",
			function()
				require("various-textobjs").visibleInWindow()
			end,
			mode = { "o", "x" },
			desc = "Visible Content",
		},

		-- 7. 键与值 (Key & Value) - 配置文件的神器
		-- 场景: 修改 JSON, YAML, TOML, Lua 表, CSS 属性
		-- ik: 选中 key (如 "debug_mode")
		-- iv: 选中 value (如 true 或 "verbose")
		{
			"ik",
			function()
				require("various-textobjs").key("inner")
			end,
			mode = { "o", "x" },
			desc = "Inner Key",
		},
		{
			"iv",
			function()
				require("various-textobjs").value("inner")
			end,
			mode = { "o", "x" },
			desc = "Inner Value",
		},

		-- 8. 数字 (Number) -
		-- -- 场景: 选中 123, -0.5f, 0xFF
		-- n: 选中光标下的任何数字（包括负号和小数点）
		-- 用法: cn (修改数值), yn (复制数值)
		{
			"n",
			function()
				require("various-textobjs").number("inner")
			end,
			mode = { "o", "x" },
			desc = "Number",
		},

		-- 9. HTML/XML 属性 (Attribute) - Vue/Web 开发必用
		-- 场景: <div class="container" v-if="show">
		-- x: 选中整个属性 (如 class="container")
		-- ix: 选中属性值 (如 "container")
		-- 用法: dx (删除属性), cix (修改属性值)
		{
			"ax",
			function()
				require("various-textobjs").htmlAttribute("outer")
			end,
			mode = { "o", "x" },
			desc = "Outer Attribute",
		},
		{
			"ix",
			function()
				require("various-textobjs").htmlAttribute("inner")
			end,
			mode = { "o", "x" },
			desc = "Inner Attribute",
		},

		-- 10. 任意引号 (Any Quote) - 不用纠结是单引号还是双引号
		-- 场景: 无论代码是用 " 还是 ' 还是 `
		-- q: 智能选中最近的引号内容
		-- 用法: ciq (直接改引号里的内容，不用管是 ci" 还是 ci')
		{
			"iq",
			function()
				require("various-textobjs").anyQuote("inner")
			end,
			mode = { "o", "x" },
			desc = "Inner Any Quote",
		},
		{
			"aq",
			function()
				require("various-textobjs").anyQuote("outer")
			end,
			mode = { "o", "x" },
			desc = "Outer Any Quote",
		},
	},

	opts = {
		-- 禁用默认通知 (如果找不到文本对象时不报错)
		notify = { done = false },
		useDefaultKeymaps = false, -- 强制手动定义按键
	},
}
