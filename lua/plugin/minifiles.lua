local show_dotfiles = true
local preview_enabled = false
local render_scheduled = false
local status_ns = vim.api.nvim_create_namespace("MiniFilesStatus")
local git_status_cache = {}

local git_status_hl = {
	added = "MiniFilesGitAdded",
	changed = "MiniFilesGitChanged",
	deleted = "MiniFilesGitDeleted",
	renamed = "MiniFilesGitRenamed",
	untracked = "MiniFilesGitUntracked",
	ignored = "MiniFilesGitIgnored",
}

local diagnostic_status = {
	[vim.diagnostic.severity.ERROR] = { text = "E", hl = "DiagnosticError" },
	[vim.diagnostic.severity.WARN] = { text = "W", hl = "DiagnosticWarn" },
	[vim.diagnostic.severity.INFO] = { text = "I", hl = "DiagnosticInfo" },
	[vim.diagnostic.severity.HINT] = { text = "H", hl = "DiagnosticHint" },
}

local status_priority = {
	["!"] = 1,
	["?"] = 2,
	A = 3,
	R = 4,
	M = 5,
	D = 6,
}

local filter_show = function()
	return true
end

local filter_hide = function(fs_entry)
	return fs_entry.name:sub(1, 1) ~= "."
end

local function normalize_path(path)
	return vim.fn.fnamemodify(path, ":p")
end

local function trim_trailing_slash(path)
	local trimmed = path:gsub("/$", "")
	if trimmed == "" then
		return "/"
	end
	return trimmed
end

local function relative_to_dir(dir, path)
	dir = trim_trailing_slash(normalize_path(dir))
	path = trim_trailing_slash(normalize_path(path))

	if path == dir then
		return ""
	end

	local prefix = dir == "/" and "/" or (dir .. "/")
	if not vim.startswith(path, prefix) then
		return nil
	end

	return path:sub(#prefix + 1)
end

local function get_current_path()
	if vim.bo.filetype == "minifiles" then
		local ok, mini_files = pcall(require, "mini.files")
		if ok then
			local fs_entry = mini_files.get_fs_entry()
			if fs_entry and fs_entry.path then
				return fs_entry.path
			end
		end
	end

	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		return vim.fn.getcwd()
	end

	return normalize_path(path)
end

local function clear_git_status_cache()
	git_status_cache = {}
end

local function set_status_highlights()
	vim.api.nvim_set_hl(0, git_status_hl.added, { link = "DiagnosticOk", default = true })
	vim.api.nvim_set_hl(0, git_status_hl.changed, { link = "DiagnosticWarn", default = true })
	vim.api.nvim_set_hl(0, git_status_hl.deleted, { link = "DiagnosticError", default = true })
	vim.api.nvim_set_hl(0, git_status_hl.renamed, { link = "DiagnosticInfo", default = true })
	vim.api.nvim_set_hl(0, git_status_hl.untracked, { link = "DiagnosticHint", default = true })
	vim.api.nvim_set_hl(0, git_status_hl.ignored, { link = "Comment", default = true })
end

local function normalize_git_status(code)
	if code == "!!" then
		return "!", git_status_hl.ignored
	end
	if code == "??" then
		return "?", git_status_hl.untracked
	end

	local index = code:sub(1, 1)
	local worktree = code:sub(2, 2)
	if index == "D" or worktree == "D" then
		return "D", git_status_hl.deleted
	end
	if index == "R" or worktree == "R" then
		return "R", git_status_hl.renamed
	end
	if index == "A" or worktree == "A" then
		return "A", git_status_hl.added
	end
	if index ~= " " or worktree ~= " " then
		return "M", git_status_hl.changed
	end
end

local function get_git_prefix(dir)
	local result = vim.system({ "git", "-C", dir, "rev-parse", "--show-prefix" }, { text = true }):wait()
	if result.code ~= 0 then
		return nil
	end

	return (result.stdout or ""):gsub("\n$", "")
end

local function set_entry_status(statuses, name, text, hl)
	local current = statuses[name]
	if not current or status_priority[text] > status_priority[current.text] then
		statuses[name] = { text = text, hl = hl }
	end
end

local function parse_git_status(dir, prefix)
	local result = vim.system({
		"git",
		"-C",
		dir,
		"status",
		"--porcelain=v1",
		"-z",
		"--ignored",
		"--untracked-files=normal",
		"--",
		".",
	}, { text = true }):wait()

	local statuses = {}
	if result.code ~= 0 then
		return statuses
	end

	local records = vim.split(result.stdout or "", "\0", { plain = true, trimempty = true })
	local i = 1
	while i <= #records do
		local record = records[i]
		local code = record:sub(1, 2)
		local path = record:sub(4):gsub("/$", "")
		if prefix and prefix ~= "" then
			if vim.startswith(path, prefix) then
				path = path:sub(#prefix + 1)
			else
				path = nil
			end
		end

		if path and path ~= "" then
			local name = path:match("^[^/]+")
			local text, hl = normalize_git_status(code)
			if name and text then
				set_entry_status(statuses, name, text, hl)
			end
		end

		if code:find("[RC]") then
			i = i + 1
		end
		i = i + 1
	end

	return statuses
end

local function get_git_status(dir)
	dir = trim_trailing_slash(normalize_path(dir))
	if git_status_cache[dir] then
		return git_status_cache[dir]
	end

	local prefix = get_git_prefix(dir)
	if not prefix then
		git_status_cache[dir] = {}
		return git_status_cache[dir]
	end

	git_status_cache[dir] = parse_git_status(dir, prefix)
	return git_status_cache[dir]
end

local function get_diagnostic_statuses(dir)
	local counts_by_name = {}

	for _, diagnostic in ipairs(vim.diagnostic.get(nil)) do
		local diagnostic_path = vim.api.nvim_buf_get_name(diagnostic.bufnr)
		if diagnostic_path ~= "" then
			local relative = relative_to_dir(dir, diagnostic_path)
			if relative and relative ~= "" then
				local name = relative:match("^[^/]+")
				if name then
					counts_by_name[name] = counts_by_name[name] or {}
					counts_by_name[name][diagnostic.severity] = (counts_by_name[name][diagnostic.severity] or 0) + 1
				end
			end
		end
	end

	local statuses = {}
	for name, counts in pairs(counts_by_name) do
		for _, severity in ipairs({
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		}) do
			local count = counts[severity]
			if count and count > 0 then
				local status = diagnostic_status[severity]
				statuses[name] = { text = status.text .. count, hl = status.hl }
				break
			end
		end
	end

	return statuses
end

local function build_status_chunks(git_statuses, diagnostic_statuses, name)
	local chunks = {}
	local git_status = git_statuses[name]
	if git_status then
		table.insert(chunks, { " " .. git_status.text, git_status.hl })
	end

	local lsp_status = diagnostic_statuses[name]
	if lsp_status then
		table.insert(chunks, { " " .. lsp_status.text, lsp_status.hl })
	end

	return chunks
end

local function clear_all_status_marks()
	for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf_id) and vim.api.nvim_buf_is_loaded(buf_id) and vim.bo[buf_id].filetype == "minifiles" then
			vim.api.nvim_buf_clear_namespace(buf_id, status_ns, 0, -1)
		end
	end
end

local function render_status_for_buffer(buf_id, dir)
	if not (vim.api.nvim_buf_is_valid(buf_id) and vim.api.nvim_buf_is_loaded(buf_id)) then
		return
	end
	if vim.bo[buf_id].filetype ~= "minifiles" then
		return
	end

	vim.api.nvim_buf_clear_namespace(buf_id, status_ns, 0, -1)

	local mini_files = require("mini.files")
	local git_statuses = get_git_status(dir)
	local diagnostic_statuses = get_diagnostic_statuses(dir)
	local line_count = vim.api.nvim_buf_line_count(buf_id)

	for line = 1, line_count do
		local fs_entry = mini_files.get_fs_entry(buf_id, line)
		if fs_entry then
			local chunks = build_status_chunks(git_statuses, diagnostic_statuses, fs_entry.name)
			if #chunks > 0 then
				vim.api.nvim_buf_set_extmark(buf_id, status_ns, line - 1, 0, {
					virt_text = chunks,
					virt_text_pos = "eol",
					priority = 200,
				})
			end
		end
	end
end

local function render_open_buffers()
	render_scheduled = false

	local mini_files = require("mini.files")
	local state = mini_files.get_explorer_state()
	if not state then
		clear_all_status_marks()
		return
	end

	local seen = {}
	for _, window in ipairs(state.windows or {}) do
		if window.win_id and vim.api.nvim_win_is_valid(window.win_id) then
			local buf_id = vim.api.nvim_win_get_buf(window.win_id)
			if not seen[buf_id] then
				seen[buf_id] = true
				render_status_for_buffer(buf_id, window.path)
			end
		end
	end

	for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf_id) and vim.api.nvim_buf_is_loaded(buf_id) and vim.bo[buf_id].filetype == "minifiles" and not seen[buf_id] then
			vim.api.nvim_buf_clear_namespace(buf_id, status_ns, 0, -1)
		end
	end
end

local function schedule_render()
	if render_scheduled then
		return
	end

	render_scheduled = true
	vim.schedule(render_open_buffers)
end

local function open_explorer(path, preview)
	preview_enabled = preview
	require("mini.files").open(path, false, {
		windows = {
			preview = preview_enabled,
		},
	})
end

local function toggle_explorer(path, preview)
	local mini_files = require("mini.files")
	if mini_files.close() then
		return
	end

	open_explorer(path, preview)
end

local function open_current_path_with_preview()
	open_explorer(get_current_path(), true)
end

local function toggle_parent_directory()
	if vim.bo.filetype == "minifiles" then
		require("mini.files").go_out()
		return
	end

	local path = get_current_path()
	if vim.fn.isdirectory(path) ~= 1 then
		path = vim.fn.fnamemodify(path, ":h")
	end

	toggle_explorer(path, false)
end

local function toggle_working_directory()
	toggle_explorer(vim.fn.getcwd(), false)
end

local function escape_minifiles()
	local mini_files = require("mini.files")
	local state = mini_files.get_explorer_state()
	if not state then
		return
	end

	local current_dir = state.branch and state.branch[state.depth_focus]
	if current_dir == nil then
		mini_files.close()
		return
	end

	if trim_trailing_slash(normalize_path(current_dir)) == trim_trailing_slash(normalize_path(vim.fn.getcwd())) then
		mini_files.close()
		return
	end

	mini_files.go_out()
end

local function open_external()
	local mini_files = require("mini.files")
	local fs_entry = mini_files.get_fs_entry()
	if not fs_entry or not fs_entry.path then
		vim.notify("当前没有可打开的条目", vim.log.levels.WARN)
		return
	end

	if vim.ui and vim.ui.open then
		vim.ui.open(fs_entry.path)
		return
	end

	local command = { "xdg-open", fs_entry.path }
	if vim.fn.has("mac") == 1 then
		command = { "open", fs_entry.path }
	elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		command = { "cmd", "/c", "start", "", fs_entry.path }
	end

	vim.fn.jobstart(command, { detach = true })
end

local function open_entry(close_on_file)
	return function()
		require("mini.files").go_in({ close_on_file = close_on_file })
	end
end

local function open_in_split(direction)
	return function()
		local mini_files = require("mini.files")
		local fs_entry = mini_files.get_fs_entry()
		if not fs_entry then
			vim.notify("当前没有可打开的条目", vim.log.levels.WARN)
			return
		end

		if fs_entry.fs_type == "directory" then
			mini_files.go_in()
			return
		end

		local state = mini_files.get_explorer_state() or {}
		local target_window = state.target_window
		if not target_window or not vim.api.nvim_win_is_valid(target_window) then
			target_window = vim.api.nvim_get_current_win()
		end

		local new_target = vim.api.nvim_win_call(target_window, function()
			vim.cmd(direction)
			return vim.api.nvim_get_current_win()
		end)

		mini_files.set_target_window(new_target)
		mini_files.go_in()
		mini_files.close()
	end
end

local function toggle_preview()
	preview_enabled = not preview_enabled
	require("mini.files").refresh({
		windows = {
			preview = preview_enabled,
		},
	})
end

local function toggle_dotfiles()
	show_dotfiles = not show_dotfiles
	require("mini.files").refresh({
		content = {
			filter = show_dotfiles and filter_show or filter_hide,
		},
	})
end

return {
	"nvim-mini/mini.files",
	version = "*",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>e",
			open_current_path_with_preview,
			desc = "Open MiniFiles with preview",
		},
		{
			"-",
			toggle_parent_directory,
			desc = "Toggle parent directory",
		},
		{
			"<leader>cw",
			toggle_working_directory,
			desc = "Toggle MiniFiles in working directory",
		},
	},
	config = function()
		local mini_files = require("mini.files")

		set_status_highlights()

		mini_files.setup({
			content = {
				filter = filter_show,
			},
			mappings = {
				go_in = "",
				go_in_plus = "",
			},
			options = {
				permanent_delete = false,
				use_as_default_explorer = true,
			},
			windows = {
				max_number = 4,
				preview = false,
				width_focus = 36,
				width_nofocus = 18,
				width_preview = 60,
			},
		})

		local group = vim.api.nvim_create_augroup("MiniFilesConfig", { clear = true })

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "MiniFilesWindowOpen",
			callback = function(args)
				local win_id = args.data.win_id
				if not win_id or not vim.api.nvim_win_is_valid(win_id) then
					return
				end

				vim.wo[win_id].winblend = 0
				local config = vim.api.nvim_win_get_config(win_id)
				config.border = "rounded"
				vim.api.nvim_win_set_config(win_id, config)
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id

				vim.keymap.set("n", "l", open_entry(true), { buffer = buf_id, desc = "Open entry and close on file" })
				vim.keymap.set("n", "L", open_entry(false), { buffer = buf_id, desc = "Open entry" })
				vim.keymap.set("n", "<CR>", open_entry(true), { buffer = buf_id, desc = "Open entry and close on file" })
				vim.keymap.set("n", "<Esc>", escape_minifiles, { buffer = buf_id, desc = "Go out or close explorer" })
				vim.keymap.set("n", "<C-s>", open_in_split("belowright vsplit"), {
					buffer = buf_id,
					desc = "Open in vertical split",
				})
				vim.keymap.set("n", "<C-h>", open_in_split("belowright split"), {
					buffer = buf_id,
					desc = "Open in horizontal split",
				})
				vim.keymap.set("n", "<C-p>", toggle_preview, { buffer = buf_id, desc = "Toggle preview" })
				vim.keymap.set("n", "<C-l>", function()
					clear_git_status_cache()
					mini_files.refresh()
				end, { buffer = buf_id, desc = "Refresh" })
				vim.keymap.set("n", "<C-c>", mini_files.close, { buffer = buf_id, desc = "Close explorer" })
				vim.keymap.set("n", "gx", open_external, { buffer = buf_id, desc = "Open with system app" })
				vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = { "MiniFilesBufferUpdate", "MiniFilesExplorerOpen", "MiniFilesExplorerClose" },
			callback = schedule_render,
		})

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = {
				"MiniFilesActionCreate",
				"MiniFilesActionDelete",
				"MiniFilesActionRename",
				"MiniFilesActionCopy",
				"MiniFilesActionMove",
			},
			callback = function()
				clear_git_status_cache()
				schedule_render()
			end,
		})

		vim.api.nvim_create_autocmd({ "BufWritePost", "FocusGained", "ShellCmdPost", "DirChanged" }, {
			group = group,
			callback = function()
				clear_git_status_cache()
				schedule_render()
			end,
		})

		vim.api.nvim_create_autocmd("DiagnosticChanged", {
			group = group,
			callback = schedule_render,
		})
	end,
}
