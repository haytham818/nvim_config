return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local parsers = {
			"bash",
			"c",
			"cpp",
			"c_sharp",
			"rust",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"dockerfile",
			"json",
			"yaml",
			"toml",
			"cmake",
			"glsl",
			"python",
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"xml",
			"diff",
			"git_config",
			"git_rebase",
			"gitcommit",
			"gitignore",
		}

		local filetypes = {
			"bash",
			"sh",
			"c",
			"cpp",
			"cs",
			"rust",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"dockerfile",
			"json",
			"yaml",
			"toml",
			"cmake",
			"glsl",
			"python",
			"html",
			"css",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"xml",
			"diff",
			"gitconfig",
			"gitrebase",
			"gitcommit",
			"gitignore",
		}

		local parser_filetypes = {
			c_sharp = "cs",
			git_config = "gitconfig",
			git_rebase = "gitrebase",
			javascript = "javascriptreact",
			tsx = "typescriptreact",
		}

		for parser, ft in pairs(parser_filetypes) do
			pcall(vim.treesitter.language.register, parser, ft)
		end

		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		if vim.fn.executable("tree-sitter") == 1 then
			require("nvim-treesitter").install(parsers)
		else
			vim.notify("tree-sitter CLI not found; nvim-treesitter parsers cannot be installed", vim.log.levels.WARN)
		end

		local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

		local function parser_installed(lang)
			return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) > 0
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = filetypes,
			callback = function(args)
				local max_filesize = 100 * 1024
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
				if ok and stats and stats.size > max_filesize then
					return
				end

				local lang = vim.treesitter.language.get_lang(args.match) or args.match
				if not parser_installed(lang) then
					return
				end

				if pcall(vim.treesitter.start, args.buf, lang) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		local selections = {}

		local function set_visual_selection(node)
			local start_row, start_col, end_row, end_col = node:range()
			end_col = math.max(end_col - 1, 0)
			vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
			vim.cmd("normal! v")
			vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
		end

		local function init_selection()
			local node = vim.treesitter.get_node()
			if not node then
				return
			end
			selections[vim.api.nvim_get_current_buf()] = { node }
			set_visual_selection(node)
		end

		local function increment_selection()
			local bufnr = vim.api.nvim_get_current_buf()
			local stack = selections[bufnr]
			if not stack or not vim.startswith(vim.fn.mode(), "v") then
				init_selection()
				return
			end

			local parent = stack[#stack] and stack[#stack]:parent()
			if parent then
				table.insert(stack, parent)
				set_visual_selection(parent)
			end
		end

		local function decrement_selection()
			local bufnr = vim.api.nvim_get_current_buf()
			local stack = selections[bufnr]
			if not stack or #stack <= 1 then
				return
			end

			table.remove(stack)
			set_visual_selection(stack[#stack])
		end

		vim.keymap.set("n", "<CR>", init_selection, { desc = "Treesitter init selection" })
		vim.keymap.set("x", "<CR>", increment_selection, { desc = "Treesitter node increment" })
		vim.keymap.set("x", "<Tab>", increment_selection, { desc = "Treesitter scope increment" })
		vim.keymap.set("x", "<BS>", decrement_selection, { desc = "Treesitter node decrement" })
	end,
}
