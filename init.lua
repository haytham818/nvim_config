vim.opt.shell = "pwsh"
vim.opt.shellcmdflag =
	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

require("config.commands")
require("config.keymaps")
require("config.options")
require("config.theme")
require("plugin.plugins")
require("config.autocmd")
require("lsp")
