return {
	"romus204/tree-sitter-manager.nvim",
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

		local has_tree_sitter_cli = vim.fn.executable("tree-sitter") == 1
		if not has_tree_sitter_cli then
			vim.notify("tree-sitter CLI not found; Tree-sitter parsers cannot be installed", vim.log.levels.WARN)
		end

		require("tree-sitter-manager").setup({
			ensure_installed = has_tree_sitter_cli and parsers or {},
			highlight = false,
			auto_install = false,
			border = "rounded",
		})

		local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

		local function parser_available(lang)
			local ok = vim.treesitter.language.add(lang)
			return ok == true
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
				if not parser_available(lang) then
					return
				end

				pcall(vim.treesitter.start, args.buf, lang)
			end,
		})

		local selections = {}

		local function parse_current_buffer(bufnr)
			local parser = vim.treesitter.get_parser(bufnr, nil, { error = false })
			if parser then
				pcall(parser.parse, parser)
			end
		end

		local function set_visual_selection(node)
			local start_row, start_col, end_row, end_col = node:range()

			if end_col == 0 then
				end_row = end_row - 1
				end_col = #vim.fn.getline(end_row + 1) + 1
			end

			vim.cmd.normal({ "v\27", bang = true })
			vim.fn.setpos("'<", { 0, start_row + 1, start_col + 1, 0 })
			vim.fn.setpos("'>", { 0, end_row + 1, end_col, 0 })
			vim.cmd.normal({ "gv", bang = true })
		end

		local function init_selection()
			local bufnr = vim.api.nvim_get_current_buf()
			parse_current_buffer(bufnr)

			local node = vim.treesitter.get_node({ bufnr = bufnr })
			if not node then
				return
			end

			selections[bufnr] = { node }
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

		vim.keymap.set("n", "<leader>vn", init_selection, { desc = "Select Treesitter node" })
		vim.keymap.set("n", "<CR>", init_selection, { desc = "Select Treesitter node" })
		vim.keymap.set("x", "<CR>", increment_selection, { desc = "Expand Treesitter selection" })
		vim.keymap.set("x", "<BS>", decrement_selection, { desc = "Shrink Treesitter selection" })
	end,
}
