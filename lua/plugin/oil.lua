local function parse_git_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout or "", "\n", { plain = true, trimempty = true }) do
			ret[line:gsub("/$", "")] = true
		end
	end
	return ret
end

local git_status_hl = {
	added = "OilGitAdded",
	changed = "OilGitChanged",
	deleted = "OilGitDeleted",
	renamed = "OilGitRenamed",
	untracked = "OilGitUntracked",
	ignored = "OilGitIgnored",
}

local status_priority = {
	["!"] = 1,
	["?"] = 2,
	A = 3,
	R = 4,
	M = 5,
	D = 6,
}

local function set_git_status_highlights()
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
	local proc = vim.system({ "git", "-C", dir, "rev-parse", "--show-prefix" }, { text = true })
	local result = proc:wait()
	if result.code ~= 0 then
		return nil
	end
	return (result.stdout or ""):gsub("\n$", "")
end

local function set_entry_status(statuses, name, text, hl)
	local current = statuses[name]
	if not current or status_priority[text] > status_priority[current[1]] then
		statuses[name] = { text, hl }
	end
end

local function parse_git_status(proc, prefix)
	local result = proc:wait()
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

local function new_git_status()
	return setmetatable({}, {
		__index = function(self, dir)
			local ignore_proc = vim.system({
				"git",
				"ls-files",
				"--ignored",
				"--exclude-standard",
				"--others",
				"--directory",
			}, { cwd = dir, text = true })
			local prefix = get_git_prefix(dir)
			local status = {}
			if prefix then
				local status_proc = vim.system({
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
				}, { text = true })
				status = parse_git_status(status_proc, prefix)
			end
			local ret = {
				ignored = parse_git_output(ignore_proc),
				status = status,
			}
			rawset(self, dir, ret)
			return ret
		end,
	})
end

return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>e",
			function()
				require("oil").open()
			end,
			desc = "Open Oil",
		},
		{
			"-",
			function()
				require("oil").toggle_float()
			end,
			desc = "Toggle Oil float",
		},
		{
			"<leader>cw",
			function()
				require("oil").toggle_float(vim.fn.getcwd())
			end,
			desc = "Toggle Oil in working directory",
		},
	},
	config = function()
		set_git_status_highlights()

		local git_status = new_git_status()
		local refresh = require("oil.actions").refresh
		local original_refresh = refresh.callback

		refresh.callback = function(...)
			git_status = new_git_status()
			original_refresh(...)
		end

		require("oil.columns").register("git_status", {
			render = function(entry, _, bufnr)
				local dir = require("oil").get_current_dir(bufnr)
				if not dir then
					return nil
				end
				local name = entry[2]
				local status = git_status[dir].status[name]
				if not status then
					return nil
				end
				return status
			end,
			parse = function(line)
				return line:match("^(%S+)%s+(.*)$")
			end,
		})

		require("oil").setup({
			default_file_explorer = true,
			columns = {
				"size",
				"mtime",
				"git_status",
				"icon",
			},
			delete_to_trash = true,
			watch_for_changes = true,
			skip_confirm_for_simple_edits = false,
			keymaps = {
				["<C-s>"] = { "actions.select", opts = { vertical = true } },
				["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["<C-l>"] = "actions.refresh",
				["q"] = { "actions.close", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
			},
			view_options = {
				show_hidden = false,
				is_hidden_file = function(name, bufnr)
					local dir = require("oil").get_current_dir(bufnr)
					if not dir then
						return false
					end
					return git_status[dir].ignored[name] == true
				end,
				natural_order = "fast",
				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
			},
			float = {
				padding = 2,
				max_width = 0.9,
				max_height = 0.9,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			confirmation = {
				border = "rounded",
			},
			progress = {
				border = "rounded",
			},
			keymaps_help = {
				border = "rounded",
			},
		})
	end,
}
