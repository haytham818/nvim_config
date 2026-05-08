return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
				"pyproject.toml",
				"Cargo.toml",
				"go.mod",
				"CMakeLists.txt",
				"*.sln",
			},
			silent_chdir = true,
		})
	end,
}
