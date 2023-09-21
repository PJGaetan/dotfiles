-- configure dap
local dap = require("dap")
dap.adapters.python = {
	type = "executable",
	command = vim.fn.exepath("debugpy-adapter"),
	args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "${workspaceFolder}/env/bin/python"
		end,
	},
}

require("dap-go").setup()

require("dapui").setup()

vim.keymap.set("n", "<leader>dk", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end)
vim.keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<leader>dt", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>dt", function()
	require("dapui").toggle()
end)
vim.keymap.set("n", "<leader>de", function()
	require("dapui").eval()
end)
