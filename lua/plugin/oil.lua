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
			local ret = {
				ignored = parse_git_output(ignore_proc),
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
			"<cmd>Oil<cr>",
			desc = "Open parent directory",
		},
		{
			"<leader>-",
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
		local git_status = new_git_status()
		local refresh = require("oil.actions").refresh
		local original_refresh = refresh.callback

		refresh.callback = function(...)
			git_status = new_git_status()
			original_refresh(...)
		end

		require("oil").setup({
			default_file_explorer = true,
			columns = {
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
