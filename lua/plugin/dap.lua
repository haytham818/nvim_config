return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui", -- 漂亮的调试界面
		"nvim-neotest/nvim-nio", -- dap-ui 的依赖
		"jay-babu/mason-nvim-dap.nvim", -- 桥接 mason 和 dap
	},
	event = "VeryLazy",
	keys = {
		-- 常用调试快捷键 (F5/F10/F11/F12 是通用标准)
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Continue",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Conditional Breakpoint",
		},
		{
			"<leader>du",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Debug: Run Last",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- 1. 初始化图形界面
		dapui.setup()

		-- 2. 自动打开/关闭调试界面
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- 3. 集成 Mason，自动安装调试器
		require("mason-nvim-dap").setup({
			-- 确保安装这些调试器 (根据你用的语言调整)
			ensure_installed = {
				"codelldb", -- C/C++/Rust
				"python", -- Python (debugpy)
			},
			-- 自动配置 handlers (核心功能)
			-- 这会尝试自动为 mason 安装的调试器设置 dap 配置
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				-- 如果某个特定语言需要特殊配置，可以在这里单独写
				-- 例如 python:
				-- python = function(config)
				--     config.adapters.python = { ... }
				--     require('mason-nvim-dap').default_setup(config)
				-- end,
			},
		})

		-- 4. 语言特定配置补充

		-- C/C++/Rust (使用 codelldb)
		-- mason-nvim-dap 的自动配置通常够用了，但如果你发现问题，
		-- 可以手动配置 dap.configurations.cpp / .c / .rust

		-- C# 配置 (因为你用了 roslyn 插件)
		dap.adapters.coreclr = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
			args = { "--interpreter=vscode" },
		}
		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
				end,
			},
		}
	end,
}
