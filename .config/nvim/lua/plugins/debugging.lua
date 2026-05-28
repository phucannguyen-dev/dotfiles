return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			local wk = require("which-key")

			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "/đường/dẫn/đến/mason/bin/OpenDebugAD7", -- Thay đổi tùy hệ điều hành
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
				},
			}
			-- Dùng chung cấu hình cho C
			dap.configurations.c = dap.configurations.cpp

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

			wk.add({
				{ "<leader>d", group = "Debug" },
				{ "<leader>db", dap.toggle_breakpoint, desc = "Breakpoint" },
				{ "<leader>dc", dap.continue, desc = "Continue/Start" },
			})
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			-- Đường dẫn đến python trong môi trường mason
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
}
