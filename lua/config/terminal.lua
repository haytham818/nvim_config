local M = {}

local terminal = {
	buf = nil,
	height = 12,
}

---@param buf integer|nil
---@return boolean
local function is_valid_buf(buf)
	return type(buf) == "number" and buf > 0 and vim.api.nvim_buf_is_valid(buf)
end

---@return integer|nil
local function terminal_win()
	if not is_valid_buf(terminal.buf) then
		return nil
	end

	local win = vim.fn.bufwinid(terminal.buf)
	if win == -1 then
		return nil
	end

	return win
end

---@param buf integer|nil
---@return boolean
local function terminal_job_running(buf)
	if not is_valid_buf(buf) or vim.bo[buf].buftype ~= "terminal" then
		return false
	end

	local ok, channel = pcall(function()
		return vim.bo[buf].channel
	end)
	if not ok or not channel or channel == 0 then
		return false
	end

	return vim.fn.jobwait({ channel }, 0)[1] == -1
end

---@param win integer
local function configure_terminal_window(win)
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"
	vim.wo[win].winbar = ""
	vim.wo[win].winfixheight = true
end

---@param buf integer
local function set_terminal_keymaps(buf)
	local opts = { buffer = buf, silent = true }
	vim.keymap.set("t", "<S-t>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

local function clear_stale_terminal()
	if is_valid_buf(terminal.buf) and not terminal_job_running(terminal.buf) then
		pcall(vim.api.nvim_buf_delete, terminal.buf, { force = true })
		terminal.buf = nil
	end
end

local function open_terminal()
	clear_stale_terminal()

	vim.cmd(("botright %dsplit"):format(terminal.height))
	local win = vim.api.nvim_get_current_win()

	if is_valid_buf(terminal.buf) then
		vim.api.nvim_win_set_buf(win, terminal.buf)
		configure_terminal_window(win)
		vim.cmd("startinsert")
		return
	end

	vim.cmd("terminal!")
	terminal.buf = vim.api.nvim_get_current_buf()
	configure_terminal_window(win)
end

function M.toggle()
	local win = terminal_win()
	if win then
		local ok = pcall(vim.api.nvim_win_close, win, true)
		if not ok and vim.api.nvim_get_current_win() == win then
			vim.cmd("enew")
		end
		return
	end

	open_terminal()
end

function M.setup()
	local group = vim.api.nvim_create_augroup("BuiltinTerminal", { clear = true })

	vim.api.nvim_create_autocmd("TermOpen", {
		group = group,
		pattern = "term://*",
		callback = function(args)
			set_terminal_keymaps(args.buf)
			configure_terminal_window(vim.api.nvim_get_current_win())
		end,
	})

	vim.api.nvim_create_autocmd("BufWipeout", {
		group = group,
		callback = function(args)
			if args.buf == terminal.buf then
				terminal.buf = nil
			end
		end,
	})

	vim.api.nvim_create_user_command("ToggleTerminal", M.toggle, { desc = "Toggle bottom terminal" })

	vim.keymap.set("n", [[<C-\>]], "<Cmd>ToggleTerminal<CR>", { desc = "Toggle terminal", silent = true })
	vim.keymap.set("i", [[<C-\>]], "<Esc><Cmd>ToggleTerminal<CR>", { desc = "Toggle terminal", silent = true })
	vim.keymap.set("t", [[<C-\>]], [[<C-\><C-n><Cmd>ToggleTerminal<CR>]], { desc = "Toggle terminal", silent = true })
end

return M
