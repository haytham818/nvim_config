return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- Telescope 的依赖
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- 图标支持
	},
	opts = {
		-- 这里是配置项
		-- 1. 设置默认编程语言 (根据你的喜好修改: python3, cpp, rust, go, java 等)
		lang = "cpp",

		-- 2. 设置使用国内版 LeetCode (leetcode.cn)
		cn = {
			enabled = true,
			translator = true, -- 开启题目翻译
			translate_problems = true,
		},

		-- 3. 存储路径 (可选，默认在 ~/.local/share/nvim/leetcode)
		-- storage = {
		--     home = vim.fn.stdpath("data") .. "/leetcode",
		--     cache = vim.fn.stdpath("cache") .. "/leetcode",
		-- },

		-- 4. 界面配置 (可选)
		injector = { --- 自定义代码注入，比如 C++ 自动加头文件
			["cpp"] = {
				before = { "#include <bits/stdc++.h>", "using namespace std;" },
				after = "int main() {}",
			},
		},
	},
}
