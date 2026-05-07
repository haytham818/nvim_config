return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		lang = "cpp",

		cn = {
			enabled = true,
			translator = true,
			translate_problems = true,
		},

		injector = {
			["cpp"] = {
				before = { "#include <bits/stdc++.h>", "using namespace std;" },
				after = "int main() {}",
			},
		},
	},
}
