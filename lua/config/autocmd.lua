-- Skip most autocmds in VSCode (VSCode handles diagnostics, UI, etc.)
if vim.g.vscode then
	return
end

-- 1. 设置 hover 的触发时间（毫秒）
-- 默认是 4000ms (4秒)，太慢了，建议设为 300ms 或 500ms
vim.opt.updatetime = 300

-- 2. 创建自动命令：当光标停留时打开诊断浮窗
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, {
			focus = false, -- 弹窗时不抢夺焦点
			scope = "cursor", -- 仅显示光标下的错误
			header = false, -- 隐藏标题，更简洁
			source = "always", -- 显示错误来源 (如 Pyright, Lua_ls)
			border = "rounded", -- 圆角边框 (美观)
		})
	end,
})

local editor_group = vim.api.nvim_create_augroup("SmartLineNumbers", { clear = true })

-- 进入插入模式，或者丢失窗口焦点时 -> 切换为绝对行号
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave", "FocusLost" }, {
	group = editor_group,
	callback = function()
		vim.opt.relativenumber = false
	end,
})

-- 离开插入模式，或者重新获得窗口焦点时 -> 切换为相对行号
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter", "FocusGained" }, {
	group = editor_group,
	callback = function()
		-- 只有在开启了行号显示的窗口才开启相对行号 (避免干扰终端窗口等)
		if vim.wo.number then
			vim.opt.relativenumber = true
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "htmldjango", "vue" },
	callback = function()
		-- 1. 禁用 smartindent (这是罪魁祸首)
		vim.opt_local.smartindent = false
		-- 2. 禁用 cindent (C语言风格缩进也不适合HTML)
		vim.opt_local.cindent = false
		-- 3. 确保 indentexpr 是由 Treesitter 接管的
		-- (通常 Treesitter 会自动设置这个，但我们为了保险起见)
		vim.opt_local.indentexpr = "nvim_treesitter#indent()"
		-- 4. 开启基础缩进
		vim.opt_local.autoindent = true
	end,
})

local save_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "WinLeave" }, {
	group = save_group,
	pattern = "*", -- 对所有文件生效
	callback = function()
		-- 1. 只有当 buffer 有文件名且被修改过时才保存
		if vim.bo.modified and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			-- silent! 忽略报错 (比如只读文件)
			vim.cmd("silent! w")
			-- 或者用 "silent! wa" 保存所有文件
		end
	end,
	desc = "Auto save on focus loss or buffer leave",
})
