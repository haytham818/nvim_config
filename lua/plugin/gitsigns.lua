return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame = false,
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, {
					buffer = bufnr,
					desc = desc,
					silent = true,
				})
			end

			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, "Next Git hunk")

			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, "Previous Git hunk")

			map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Git hunk")
			map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Git hunk")
			map("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage Git hunk")
			map("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset Git hunk")

			map("n", "<leader>gS", gitsigns.stage_buffer, "Stage Git buffer")
			map("n", "<leader>gR", gitsigns.reset_buffer, "Reset Git buffer")
			map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Git hunk")
			map("n", "<leader>gi", gitsigns.preview_hunk_inline, "Preview Git hunk inline")
			map("n", "<leader>gb", function()
				gitsigns.blame_line({ full = true })
			end, "Blame Git line")
			map("n", "<leader>gd", gitsigns.diffthis, "Diff current buffer")
			map("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end, "Diff current buffer against previous revision")
			map("n", "<leader>gq", gitsigns.setqflist, "Git hunks to quickfix")
			map("n", "<leader>gQ", function()
				gitsigns.setqflist("all")
			end, "Git hunks to quickfix for repository")
			map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, "Toggle Git line blame")
			map("n", "<leader>gtw", gitsigns.toggle_word_diff, "Toggle Git word diff")
			map({ "o", "x" }, "ih", gitsigns.select_hunk, "Git hunk")
		end,
	},
}
