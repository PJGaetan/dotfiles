return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap-python",
		},
		lazy = true,
		keys = {
			"<leader>dm",
			"<leader>b",
			"<leader>db",
			"<leader>dt",
			"<leader>dc",
		},
		config = function()
			-- configure dap
			local dap = require("dap")
			dap.defaults.fallback.exception_breakpoints = { "raised", "uncaught", "uncaughted" }
			require("nvim-dap-virtual-text").setup()
			require("dap-go").setup()
			require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
			local dap_python = require("dap-python")
			dap_python.test_runner = "pytest"

			require("dap-python").resolve_python = function()
				local cwd = vim.fn.getcwd()

				if vim.fn.executable("poetry") == 1 then
					local path = vim.cmd("poetry env info --path")
					return path
				end

				if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				elseif vim.fn.executable(cwd .. "/env/bin/python") == 1 then
					return cwd .. "/env/bin/python"
				else
					return "/usr/bin/python"
				end
			end

			-- insert django config
			table.insert(dap.configurations.python, {
				type = "debugpy",
				request = "launch",
				name = "Django",
				program = "${workspaceFolder}/manage.py",
				args = { "runserver" },
				justMyCode = true,
				django = true,
				console = "integratedTerminal",
			})

			vim.keymap.set("n", "<leader>dm", function()
				require("dap-python").test_method()
			end)

			require("dapui").setup()
			local dapui = require("dapui")

			vim.keymap.set("n", "<leader>b", function()
				dap.toggle_breakpoint()
			end)

			vim.keymap.set("n", "<leader>db", function()
				dap.run_to_cursor()
			end)

			-- eval under cursor
			vim.keymap.set("n", "<leader>?", function()
				dapui.eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end)
			vim.keymap.set("n", "<leader>dl", function()
				dap.run_last()
			end)
			vim.keymap.set("n", "<leader>do", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end)

			vim.keymap.set("n", "<leader>dt", function()
				dapui.toggle()
			end)

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
		end,
	},
}
