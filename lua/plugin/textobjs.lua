return {
	"chrisgrieser/nvim-various-textobjs",
	lazy = true,
	keys = {

		-- ii: 选中当前缩进层级的内容
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

		-- 整个缓冲区
		{
			"gG",
			function()
				require("various-textobjs").entireBuffer()
			end,
			mode = { "o", "x" },
			desc = "Entire Buffer",
		},

		-- 子单词
		{
			"S",
			function()
				require("various-textobjs").subword("inner")
			end,
			mode = { "o", "x" },
			desc = "Inner Subword",
		},

		-- URL 链接
		{
			"L",
			function()
				require("various-textobjs").url()
			end,
			mode = { "o", "x" },
			desc = "Link / URL",
		},

		-- 诊断信息
		{
			"!",
			function()
				require("various-textobjs").diagnostic()
			end,
			mode = { "o", "x" },
			desc = "Diagnostic Scope",
		},

		-- 可见区域
		{
			"V",
			function()
				require("various-textobjs").visibleInWindow()
			end,
			mode = { "o", "x" },
			desc = "Visible Content",
		},

		-- 键与值
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

		-- 数字
		{
			"n",
			function()
				require("various-textobjs").number("inner")
			end,
			mode = { "o", "x" },
			desc = "Number",
		},

		-- . HTML/XML 属性 (Attribute) - Vue/Web 开发必用
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

		-- 引号
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
		notify = { done = false },
		useDefaultKeymaps = false,
	},
}
