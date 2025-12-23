vim.api.nvim_create_user_command("FormatToggle", function(args)
	local is_global = not args.bang
	if is_global then
		vim.g.disable_autoformat = not vim.g.disable_autoformat
		if vim.g.disable_autoformat then
			print("已禁用全局自动格式化")
		else
			print("已启用全局自动格式化")
		end
	else
		vim.b.disable_autoformat = not vim.b.disable_autoformat
		if vim.b.disable_autoformat then
			print("已禁用当前 Buffer 自动格式化")
		else
			print("已启用当前 Buffer 自动格式化")
		end
	end
end, {
	desc = "Toggle autoformat-on-save",
	bang = true,
})
