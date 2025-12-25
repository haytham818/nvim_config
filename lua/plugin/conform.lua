return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	cond = not vim.g.vscode,

	-- 将快捷键定义移到 Lazy 的 keys 模块中，更规范
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({
					lsp_format = "fallback",
					async = true,
					timeout_ms = 3000,
				})
			end,
			mode = { "n", "v" },
			desc = "Format current buffer",
		},
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			toml = { "taplo" },
			cs = { "csharpier" },
			rust = { "rustfmt", lsp_format = "fallback" },
			-- Web 全家桶
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			python = { "isort", "black" },
		},

		-- 3. 自动保存配置
		format_on_save = function(bufnr)
			-- 如果设置了禁用，则跳过
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			return {
				timeout_ms = 3000, -- 4. 关键：这里也要改成 3000ms
				lsp_format = "fallback", -- 保持一致
				async = false, -- 保存时建议阻塞，防止写入冲突
			}
		end,

		formatters = {
			["clang-format"] = {
				prepend_args = { "--style=file", "--fallback-style=Microsoft" },
			},
		},
	},

	config = function(_, opts)
		require("conform").setup(opts)

		-- Add command to toggle format on save
		vim.api.nvim_create_user_command("FormatToggle", function()
			vim.g.disable_autoformat = not (vim.g.disable_autoformat or false)
			if vim.g.disable_autoformat then
				vim.notify("Format on save disabled", vim.log.levels.INFO)
			else
				vim.notify("Format on save enabled", vim.log.levels.INFO)
			end
		end, {
			desc = "Toggle format on save",
		})
	end,
}
