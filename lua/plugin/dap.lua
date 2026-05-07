return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
	},
	event = "VeryLazy",
	keys = {
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

		dapui.setup()

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
			ensure_installed = {
				"codelldb", -- C/C++/Rust
				"coreclr", -- C#/.NET
				"python", -- Python (debugpy)
			},
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		local netcoredbg = vim.fn.exepath("netcoredbg")
		if netcoredbg == "" then
			netcoredbg = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"
		end

		dap.adapters.coreclr = {
			type = "executable",
			command = netcoredbg,
			args = { "--interpreter=vscode" },
			options = vim.fn.has("win32") == 1 and { detached = false } or nil,
		}

		local function pick_debug_dll()
			local root = vim.fs.root(0, function(name, _)
				return name:match("%.slnx?$") ~= nil or name:match("%.csproj$") ~= nil
			end) or vim.fn.getcwd()
			local dlls = vim.fn.glob(vim.fs.joinpath(root, "bin", "Debug", "**", "*.dll"), false, true)

			if #dlls == 1 then
				return dlls[1]
			end

			if #dlls > 1 then
				return coroutine.create(function(coro)
					vim.ui.select(dlls, { prompt = "Select debug DLL:" }, function(choice)
						coroutine.resume(coro, choice)
					end)
				end)
			end

			return vim.fn.input("Path to dll: ", vim.fs.joinpath(root, "bin", "Debug") .. "/", "file")
		end

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "Launch .NET project DLL",
				request = "launch",
				program = pick_debug_dll,
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				stopAtEntry = false,
			},
		}
	end,
}
