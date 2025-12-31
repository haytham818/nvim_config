-- Cross-platform shell configuration
-- Automatically use PowerShell on Windows if available
if vim.fn.has("win32") == 1 then
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
end


if vim.fn.has("win32") == 0 then
    -- Use zsh on Unix-like systems if available
    if vim.fn.executable("zsh") == 1 then
        vim.opt.shell = "zsh"
    end
end

if vim.fn.has("win32") == 1 then
    -- Use pwsh on Windows if available
    if vim.fn.executable("pwsh") == 1 then
        vim.opt.shell = "pwsh"
    end
end

require("config.commands")
require("config.keymaps")
require("config.options")
require("config.theme")
require("plugin.plugins")
require("config.autocmd")
require("lsp")
