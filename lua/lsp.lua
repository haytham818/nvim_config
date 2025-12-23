-- Remove Global Default Key mapping
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gO")

-- Create keymapping
-- LspAttach: After an LSP Client performs "initialize" and attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local keymap = vim.keymap
		local lsp = vim.lsp
		local bufopts = { noremap = true, silent = true }

		keymap.set("n", "gr", lsp.buf.references, bufopts)
		keymap.set("n", "gd", lsp.buf.definition, bufopts)
		keymap.set("n", "<space>rn", lsp.buf.rename, bufopts)
		keymap.set("n", "K", lsp.buf.hover, bufopts)
		-- use conform.nvim
		-- keymap.set("n", "<space>f", function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, bufopts)
		keymap.set("n", "<leader>ca", lsp.buf.code_action, { desc = "Code Action" })
	end,
})

-- 开启内联提示
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- 开启 Inlay Hints
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end
		vim.keymap.set("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Toggle Inlay Hints" })
	end,
})

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
	signs = true, -- 在行号左侧显示图标
	underline = true,
	update_in_insert = false, -- 输入时不要一直闪烁报错，退出插入模式再报错
})

-- 修改左侧行号栏的错误图标 (需要 Nerd Font)
-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
		-- 以下选项可选，保持默认即可
		-- linehl = false, -- 是否高亮整行
		-- numhl = true, -- 是否高亮行号
	},
})

vim.lsp.enable({
	"clangd",
	"neocmake",
	"taplo",
	"stylua",
	"rust_analyzer",
	"lua_ls",
	-- "html",
	-- "cssls",
	-- "emmet_language_server",
})
