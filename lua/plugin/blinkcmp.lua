return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",

	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "super-tab",
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		snippets = {
			preset = "luasnip",
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				cmdline = {
					min_keyword_length = function(ctx)
						if ctx.mode == "cmdline" and vim.fn.getcmdtype() == ":" and not ctx.line:find("%s") then
							return 1
						end

						return 0
					end,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust" },

		completion = {
			keyword = { range = "prefix" },

			menu = {
				border = "rounded",
				max_height = 12,
				direction_priority = function()
					if vim.api.nvim_get_mode().mode == "c" or vim.fn.win_gettype() == "command" then
						return { "n", "s" }
					end

					return { "s", "n" }
				end,
				cmdline_position = function()
					-- noice exposes the bottom cmdline anchor via vim.g.ui_cmdline_pos
					local pos = vim.g.ui_cmdline_pos
					if pos ~= nil then
						local row = pos[1] or pos.row
						local col = pos[2] or pos.col or 0
						if row ~= nil then
							return { row - 1, col }
						end
					end

					local height = vim.o.cmdheight == 0 and 1 or vim.o.cmdheight
					return { vim.o.lines - height, 0 }
				end,
				draw = {
					treesitter = { "lsp" },

					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
				},
			},

			trigger = { show_on_trigger_character = true },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				treesitter_highlighting = true,
				window = {
					border = "rounded",
					max_height = 20,
					max_width = 60,
				},
			},
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
		},

		cmdline = {
			keymap = {
				preset = "none",
				["<Tab>"] = { "show", "accept", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-Space>"] = { "show", "fallback" },
				["<C-e>"] = { "cancel", "fallback" },
				["<CR>"] = { "accept_and_enter", "fallback" },
			},
			sources = function()
				local cmdtype = vim.fn.getcmdtype()
				if cmdtype == ":" then
					return { "cmdline", "path" }
				end

				if cmdtype == "/" or cmdtype == "?" then
					return { "buffer" }
				end

				return { "buffer", "cmdline" }
			end,
			completion = {
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				menu = {
					auto_show = function()
						return vim.fn.getcmdtype() == ":"
					end,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
				ghost_text = {
					enabled = function()
						return vim.fn.getcmdtype() == ":"
					end,
				},
			},
		},

		signature = {
			enabled = true,
			window = {
				border = "rounded",
				treesitter_highlighting = true,
			},
		},
	},
	opts_extend = { "sources.default" },
	config = function(_, opts)
		require("blink.cmp").setup(opts)
	end,
}
