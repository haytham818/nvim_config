return {
	"Vigemus/iron.nvim",
	keys = {
		{ "<space>rr", mode = { "n" }, desc = "Iron: Toggle REPL" },
		{ "<space>rR", mode = { "n" }, desc = "Iron: Restart REPL" },
		{ "<space>sc", mode = { "n", "v" }, desc = "Iron: Send Motion/Visual" },
		{ "<space>sf", mode = { "n" }, desc = "Send File" },
		{ "<space>sl", mode = { "n" }, desc = "Send Line" },
		{ "<space>sp", mode = { "n" }, desc = "Send Paragraph" },
		{ "<space>su", mode = { "n" }, desc = "Send Until Cursor" },
		{ "<space>sm", mode = { "n" }, desc = "Send Mark" },
		{ "<space>sb", mode = { "n" }, desc = "Send Code Block" },
		{ "<space>sn", mode = { "n" }, desc = "Send Code Block and Move" },
		{ "<space>mc", mode = { "n", "v" }, desc = "Mark Motion/Visual" },
		{ "<space>md", mode = { "n" }, desc = "Remove Mark" },
		{ "<space>s<cr>", mode = { "n" }, desc = "CR" },
		{ "<space>s<space>", mode = { "n" }, desc = "Interrupt" },
		{ "<space>sq", mode = { "n" }, desc = "Exit" },
		{ "<space>cl", mode = { "n" }, desc = "Clear" },
	},
	config = function()
		local iron = require("iron.core")
		local view = require("iron.view")
		local common = require("iron.fts.common")

		iron.setup({
			config = {
				scratch_repl = true,

				repl_definition = {
					haskell = {
						command = {
							"ghci",
						},
						-- Add :{  :} for ghci multiple lines send
						format = function(lines)
							if #lines > 1 then
								local formatted = { ":{" }
								for _, line in ipairs(lines) do
									table.insert(formatted, line)
								end
								table.insert(formatted, ":}")
								-- ENTER
								table.insert(formatted, "")
								return formatted
							end
							return {
								lines[1],
								"",
							}
						end,
					},
					sh = {
						command = {
							"zsh",
						},
					},
					python = {
						command = {
							"python3",
						},
						format = common.bracketed_paste_python,
						block_dividers = {
							"# %%",
							"#%%",
						},
						env = {
							PYTHON_BASIC_REPL = "1",
						},
					},
					cs = {
						command = {
							"dotnet",
							"script",
						},
					},
				},

				repl_open_cmd = view.split.horizontal.botright(15),

				repl_filetype = function(_, ft)
					return ft
				end,
			},
			keymaps = {
				toggle_repl = "<space>rr",
				restart_repl = "<space>rR",
				send_motion = "<space>sc",
				visual_send = "<space>sc",
				send_file = "<space>sf",
				send_line = "<space>sl",
				send_paragraph = "<space>sp",
				send_until_cursor = "<space>su",
				send_mark = "<space>sm",
				send_code_block = "<space>sb",
				send_code_block_and_move = "<space>sn",
				mark_motion = "<space>mc",
				mark_visual = "<space>mc",
				remove_mark = "<space>md",
				cr = "<space>s<cr>",
				interrupt = "<space>s<space>",
				exit = "<space>sq",
				clear = "<space>cl",
			},
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true,
		})
	end,
}
