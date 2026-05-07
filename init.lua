vim.opt.runtimepath:append("/home/haytham/.local/share/nvim/site")

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
	-- Unix: prefer zsh if available
	if vim.fn.executable("zsh") == 1 then
		vim.opt.shell = "zsh"
	else
		vim.opt.shell = "bash"
	end
end

require("config.commands")
require("config.keymaps")
require("config.options")
require("config.theme")
require("plugin.plugins")
require("config.autocmd")
require("lsp")

-- Neovide GUI
require("config.neovide")
