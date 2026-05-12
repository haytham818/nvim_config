vim.opt.runtimepath:append("/home/haytham/.local/share/nvim/site")

require("config.platform")
require("config.commands")
require("config.keymaps")
require("config.options")
require("config.theme")
require("plugin.plugins")
require("config.autocmd")
require("config.terminal").setup()
require("lsp")

-- Neovide GUI
require("config.neovide")
