local function is_visual_mode(mode)
	return mode == "v" or mode == "V" or mode == "\22"
end

local function get_visual_range()
	-- Build an explicit end-exclusive range for the current visual selection.
	local mode = vim.fn.mode()
	local start_pos = vim.fn.getpos("v")
	local end_pos = vim.fn.getpos(".")
	local start_row = start_pos[2]
	local start_col = start_pos[3]
	local end_row = end_pos[2]
	local end_col = end_pos[3]

	if start_row > end_row or (start_row == end_row and start_col > end_col) then
		start_row, end_row = end_row, start_row
		start_col, end_col = end_col, start_col
	end

	if mode == "V" then
		start_col = 1
		local end_line = vim.api.nvim_buf_get_lines(0, end_row - 1, end_row, true)[1] or ""
		end_col = #end_line
	end

	return {
		start = { start_row, start_col - 1 },
		["end"] = { end_row, end_col },
	}
end

local function has_lsp_client_supporting(method, opts)
	opts = opts or {}
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		if (not opts.name or client.name == opts.name) and client:supports_method(method) then
			return true
		end
	end

	return false
end

local function has_available_conform_formatter(bufnr)
	local conform = require("conform")

	for _, name in ipairs(conform.list_formatters_for_buffer(bufnr)) do
		if conform.get_formatter_info(name, bufnr).available then
			return true
		end
	end

	return false
end

local function can_range_format(bufnr)
	if vim.bo[bufnr].filetype == "cs" then
		return has_lsp_client_supporting("textDocument/rangeFormatting", {
			bufnr = bufnr,
			name = "roslyn",
		})
	end

	if has_available_conform_formatter(bufnr) then
		return true
	end

	return has_lsp_client_supporting("textDocument/rangeFormatting", { bufnr = bufnr })
end

local function can_buffer_format(bufnr)
	if has_available_conform_formatter(bufnr) then
		return true
	end

	return has_lsp_client_supporting("textDocument/formatting", { bufnr = bufnr })
end

local function format_buffer()
	require("conform").format({
		bufnr = 0,
		lsp_format = "fallback",
		async = true,
		timeout_ms = 3000,
	})
end

local function format_buffer_from_any_mode()
	local mode = vim.api.nvim_get_mode().mode

	if is_visual_mode(mode) then
		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		vim.api.nvim_feedkeys(esc, "nx", false)
		vim.schedule(format_buffer)
		return
	end

	format_buffer()
end

local function format_selection()
	local bufnr = vim.api.nvim_get_current_buf()
	local range = get_visual_range()

	if vim.bo[bufnr].filetype == "cs" and has_lsp_client_supporting("textDocument/rangeFormatting", {
		bufnr = bufnr,
		name = "roslyn",
	}) then
		require("conform").format({
			bufnr = bufnr,
			formatters = {},
			lsp_format = "prefer",
			async = true,
			timeout_ms = 3000,
			filter = function(client)
				return client.name == "roslyn"
			end,
			range = range,
		})
		return
	end

	if can_range_format(bufnr) then
		require("conform").format({
			bufnr = bufnr,
			lsp_format = "fallback",
			async = true,
			timeout_ms = 3000,
			range = range,
		})
		return
	end

	if can_buffer_format(bufnr) then
		vim.notify("当前语言不支持选区格式化，请使用 <leader>cF 格式化整个 buffer。", vim.log.levels.INFO)
	else
		vim.notify("当前 buffer 没有可用的格式化器。", vim.log.levels.WARN)
	end
end

return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },

	keys = {
		{
			"<leader>cf",
			format_selection,
			mode = "x",
			desc = "Format selection",
		},
		{
			"<leader>cF",
			format_buffer_from_any_mode,
			mode = { "n", "x" },
			desc = "Format buffer",
		},
	},

	opts = {
		formatters_by_ft = {
			lua             = { "stylua" },
			c               = { "clang-format" },
			cpp             = { "clang-format" },
			toml            = { "taplo" },
			cs              = { "csharpier" },
			rust            = { "rustfmt", lsp_format = "fallback" },
			zig             = { "zigfmt" },
			javascript      = { "prettier" },
			typescript      = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			css             = { "prettier" },
			html            = { "prettier" },
			json            = { "prettier" },
			yaml            = { "prettier" },
			markdown        = { "prettier" },
			python          = { "isort", "black" },
		},

		formatters = {
			["clang-format"] = {
				prepend_args = { "--style=file", "--fallback-style=Microsoft" },
			},
		},
	},

	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
