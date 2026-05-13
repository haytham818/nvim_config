return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets" },

	-- Use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use Nix, you can build from source using the latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to VSCode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			-- Each keymap may be a list of commands and/or functions
			preset = "super-tab",
			-- Select completions
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			-- Scroll documentation
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			-- Show/hide signature
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		snippets = {
			preset = "luasnip",
		},

		sources = {
			-- `lsp`, `buffer`, `snippets`, `path`, and `omni` are built-in
			-- so you don't need to define them in `sources.providers`
			default = { "lsp", "path", "snippets", "buffer" },

			-- Sources are configured via the sources.providers table
		},

		-- Keep the safer Lua matcher. The Rust matcher was part of the crash path.
		fuzzy = { implementation = "lua" },
		completion = {
			-- The keyword should only match against the text before
			keyword = { range = "prefix" },
			menu = {
				draw = {
					treesitter = { "lsp" },

					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},

					-- componets = {
					-- label = {
					-- width = {
					-- fill = true,
					-- max = 60,
					-- },
					-- 	text = function(ctx)
					-- 		return ctx.label .. ctx.label_description
					-- 	end,
					-- },
					-- label_description = {
					-- 	width = {
					-- 		max = 30,
					-- 	},
					-- },
					-- },
				},
				border = "rounded",
				max_height = 15,
			},
			-- Show completions after typing a trigger character, defined by the source
			trigger = { show_on_trigger_character = true },
			documentation = {
				-- Show documentation automatically
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

		-- Signature help when tying
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
