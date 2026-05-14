return {
	"ionide/Ionide-vim",
	ft = { "fsharp", "fsharp_project" },
	init = function()
		vim.filetype.add({
			extension = {
				fsproj = "fsharp_project",
			},
		})

		vim.g["fsharp#backend"] = "nvim"
		vim.g["fsharp#fsautocomplete_command"] = { "fsautocomplete", "--background-service-enabled" }
		vim.g["fsharp#fsi_window_command"] = "botright 15new"
		vim.g["fsharp#lsp_auto_setup"] = 0
		vim.g["fsharp#lsp_recommended_colorscheme"] = 0
	end,
	config = function()
		vim.lsp.config("ionide", {
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/codeLens") then
					vim.lsp.codelens.enable(true, { bufnr = bufnr })
				end
			end,
		})
		vim.lsp.enable("ionide")

		local group = vim.api.nvim_create_augroup("UserFSharpKeymaps", { clear = true })

		local function set_keymaps(bufnr)
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, {
					buffer = bufnr,
					silent = true,
					desc = desc,
				})
			end

			map("n", "<leader>fi", "<cmd>FsiShow<CR>", "F#: Toggle FSI")
			map("n", "<leader>fb", "<cmd>FsiEvalBuffer<CR>", "F#: Send buffer to FSI")
			map("n", "<leader>fr", "<cmd>FsiReset<CR>", "F#: Reset FSI")
			map("n", "<leader>ft", function()
				vim.fn["fsharp#showTooltip"]()
			end, "F#: Show tooltip")
			map("n", "<leader>fs", function()
				vim.fn["fsharp#sendLineToFsi"]()
			end, "F#: Send line to FSI")
			map("x", "<leader>fs", function()
				vim.fn["fsharp#sendSelectionToFsi"]()
				local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
				vim.api.nvim_feedkeys(esc, "nx", false)
			end, "F#: Send selection to FSI")
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = "fsharp",
			callback = function(args)
				set_keymaps(args.buf)
			end,
		})

		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype == "fsharp" then
				set_keymaps(bufnr)
			end
		end
	end,
}
