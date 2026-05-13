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
		},

		fuzzy = { implementation = "lua" },

		completion = {
			keyword = { range = "prefix" },

			menu = {
				draw = {
					treesitter = { "lsp" },

					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
				},
				border = "rounded",
				max_height = 15,
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

		local function is_haskell(ft)
			return ft == "haskell" or ft == "lhaskell"
		end

		local function sync_popup_treesitter(bufnr)
			local ft = vim.bo[bufnr or 0].filetype
			if vim.startswith(ft, "blink-cmp-") then
				return
			end

			local cfg = require("blink.cmp.config")
			local disable = is_haskell(ft)
			cfg.completion.menu.draw.treesitter = disable and {} or { "lsp" }
			cfg.completion.documentation.treesitter_highlighting = not disable
			cfg.signature.window.treesitter_highlighting = not disable
		end

		local group = vim.api.nvim_create_augroup("UserBlinkCmpTreesitterSafety", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
			group = group,
			callback = function(args)
				sync_popup_treesitter(args.buf)
			end,
		})

		vim.schedule(function()
			sync_popup_treesitter(vim.api.nvim_get_current_buf())
		end)
	end,
}
