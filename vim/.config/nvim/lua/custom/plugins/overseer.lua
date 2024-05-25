return {
	"stevearc/overseer.nvim",
	config = function()
		require("overseer").setup({})
		vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<CR>")
		vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<CR>")
	end,
	cmd = { "OverseerRun", "OverseerToggle" },
}
