local function feed_command_line(command)
	local keys = vim.api.nvim_replace_termcodes(command, true, false, true)
	vim.api.nvim_feedkeys(keys, "nt", false)
end

local function get_command_palette_items()
	local user_commands = vim.api.nvim_get_commands({})
	local buffer_commands = vim.api.nvim_buf_get_commands(0, {})
	buffer_commands[true] = nil

	local items = {}
	for _, name in ipairs(vim.fn.getcompletion("", "command")) do
		local command_info = buffer_commands[name] or user_commands[name]
		local kind = "builtin"
		if buffer_commands[name] ~= nil then
			kind = "buffer"
		elseif user_commands[name] ~= nil then
			kind = "user"
		end

		items[#items + 1] = {
			name = name,
			kind = kind,
			nargs = command_info and command_info.nargs or nil,
		}
	end

	table.sort(items, function(left, right)
		local left_is_word = left.name:match("^[%a]") ~= nil
		local right_is_word = right.name:match("^[%a]") ~= nil
		if left_is_word ~= right_is_word then
			return left_is_word
		end

		return left.name < right.name
	end)

	return items
end

local function open_command_palette()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local config = require("telescope.config").values
	local entry_display = require("telescope.pickers.entry_display")
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local themes = require("telescope.themes")

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 28 },
			{ remaining = true },
		},
	})

	local function make_display(entry)
		local kind_highlights = {
			builtin = "Comment",
			user = "Identifier",
			buffer = "Type",
		}
		return displayer({
			entry.value.name,
			{ "[" .. entry.value.kind .. "]", kind_highlights[entry.value.kind] or "Comment" },
		})
	end

	local function accept_selection(prompt_bufnr, execute_zero_arg_command)
		local selection = action_state.get_selected_entry()
		if selection == nil then
			return
		end

		actions.close(prompt_bufnr)
		vim.schedule(function()
			local item = selection.value
			if execute_zero_arg_command and item.nargs == "0" then
				vim.cmd(item.name)
				return
			end

			feed_command_line(":" .. item.name .. " ")
		end)
	end

	-- telescope.builtin.commands() only uses nvim_get_commands(), which omits builtin Ex commands.
	pickers
		.new(themes.get_ivy({
			previewer = false,
			layout_config = { height = 0.35 },
		}), {
			prompt_title = "Command Palette",
			finder = finders.new_table({
				results = get_command_palette_items(),
				entry_maker = function(item)
					return {
						value = item,
						ordinal = item.name .. " " .. item.kind,
						display = make_display,
					}
				end,
			}),
			sorter = config.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					accept_selection(prompt_bufnr, true)
				end)

				map({ "i", "n" }, "<C-e>", function()
					accept_selection(prompt_bufnr, false)
				end)

				return true
			end,
		})
		:find()
end

local function open_command_history()
	require("telescope.builtin").command_history()
end

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
		{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Telescope projects" },
		{ "<leader>:", open_command_palette, desc = "Command palette" },
		{ "<leader>f:", open_command_history, desc = "Command history" },
		{ "<M-x>", open_command_palette, desc = "Command palette" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				file_ignore_patterns = { "node_modules", ".git" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.87,
					height = 0.80,
				},
				sorting_strategy = "ascending",
			},
			pickers = {
				command_history = {
					theme = "ivy",
					previewer = false,
					initial_mode = "insert",
					layout_config = {
						height = 0.25,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						previewer = true,
					}),
				},
				fzf = {},
				projects = {},
			},
		})

		telescope.load_extension("ui-select")
		telescope.load_extension("fzf")
		telescope.load_extension("projects")
	end,
}
