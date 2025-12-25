local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- require("plugin.monokai"),
	-- require("plugin.onedarkpro"),
	-- require("plugin.gruvbox"),
	require("plugin.gruvboxmat"),
	require("plugin.mason"),
	require("plugin.blinkcmp"),
	require("plugin.bufferline"),
	require("plugin.conform"),
	require("plugin.lualine"),
	require("plugin.neotree"),
	require("plugin.treesitter"),
	require("plugin.noice"),
	require("plugin.blankline"),
	require("plugin.autopairs"),
	require("plugin.whichkey"),
	require("plugin.telescope"),
	require("plugin.comment"),
	require("plugin.terminal"),
	require("plugin.surround"),
	require("plugin.todo"),
	require("plugin.flash"),
	require("plugin.persistence"),
	require("plugin.luasnip"),
	require("plugin.autotag"),
	require("plugin.lazygit"),
	require("plugin.corn"),
	require("plugin.focus"),
	require("plugin.arrow"),
	require("plugin.dial"),
	require("plugin.textobjs"),
	require("plugin.yanky"),
	require("plugin.quicker"),
	require("plugin.markview"),
	require("plugin.precognition"),
	require("plugin.lazydev"),
	require("plugin.yazi"),
	require("plugin.roslyn"),
	require("plugin.overseer"),
})
