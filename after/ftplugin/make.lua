-- make.lua
-- 只有在该 buffer 是 makefile 类型时才会生效

-- 关键：关闭将 Tab 转换为空格（即使用硬 Tab）
vim.opt_local.expandtab = false

-- 设定 Tab 显示的宽度为 4 (或者 8，看你喜好，但这只影响显示)
vim.opt_local.tabstop = 4

-- 设定自动缩进的宽度也为 4
vim.opt_local.shiftwidth = 4
