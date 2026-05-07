-- Remove global default key mappings.
for _, lhs in ipairs({ "grn", "gra", "grr", "gri", "gO" }) do
	pcall(vim.keymap.del, "n", lhs)
end

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(args)
		local keymap = vim.keymap
		local lsp = vim.lsp
		local bufopts = { buffer = args.buf, noremap = true, silent = true }

		keymap.set("n", "gr", lsp.buf.references, bufopts)
		keymap.set("n", "gd", lsp.buf.definition, bufopts)
		keymap.set("n", "gD", lsp.buf.declaration, bufopts)
		keymap.set("n", "gi", lsp.buf.implementation, bufopts)
		keymap.set("n", "<space>rn", lsp.buf.rename, bufopts)
		keymap.set("n", "K", lsp.buf.hover, bufopts)
		keymap.set("n", "<leader>ca", lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "Code Action" }))

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end

		vim.keymap.set("n", "<leader>th", function()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
			vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
		end, vim.tbl_extend("force", bufopts, { desc = "Toggle Inlay Hints" }))
	end,
})

-- 诊断显示配置 (统一入口，避免重复调用)
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- 或者是 '■', '▎', 'x'
		-- 如果你觉得行尾的错误文字太乱，可以设为 false，只靠悬停看错误
		-- source = "if_many",
	},
	float = {
		source = "always", -- 浮窗中显示是由哪个 LSP 报错的
		border = "rounded",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	update_in_insert = false, -- 输入时不要一直闪烁报错，退出插入模式再报错
	severity_sort = true, -- Sort diagnostics by severity
})

vim.lsp.enable({
	"roslyn_ls",
	"clangd",
	"neocmake",
	"stylua",
	"rust_analyzer",
	"lua_ls",
	"pyright",
	"taplo",
	"zls",
})
