-- 1. 设置 hover 的触发时间（毫秒）
-- 默认是 4000ms (4秒)，太慢了，建议设为 300ms 或 500ms
vim.opt.updatetime = 300

-- 2. 创建自动命令：当光标停留时打开诊断浮窗（仅当有诊断信息时）
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
	callback = function()
		-- 只有当前行存在诊断信息时才弹窗，避免空消耗
		local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
		if #diagnostics == 0 then
			return
		end
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

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	group = save_group,
	pattern = "*", -- 对所有文件生效
	callback = function()
		local has_file = vim.api.nvim_buf_get_name(0) ~= ""
		if
			has_file
			and vim.bo.modified
			and vim.bo.buftype == ""
			and vim.bo.modifiable
			and not vim.bo.readonly
		then
			vim.cmd("silent! update")
		end
	end,
	desc = "Auto save on focus loss or buffer leave",
})
