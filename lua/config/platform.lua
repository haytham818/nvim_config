-- Cross-platform shell configuration
if vim.fn.has("win32") == 1 then
	-- Windows: PowerShell / pwsh
	local powershell_options = {
		shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
		shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		shellquote = "",
		shellxquote = "",
	}
	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end
else
	-- Unix: prefer zsh if available or bash
	if vim.fn.executable("zsh") == 1 then
		vim.opt.shell = "zsh"
	else
		vim.opt.shell = "bash"
	end
end
