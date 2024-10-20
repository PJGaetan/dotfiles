return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({
			spinnerStates = false,
			resultsSeparatorLineChar = "-",
			maxSearchCharsInTitles = 0,
			icons = {
				-- whether to show icons
				enabled = true,
			},
		})
		vim.keymap.set("n", "<leader>sr", "<cmd>GrugFar<CR>", { desc = "Replace word under cursor" })
	end,
	lazy = true,
	cmd = {
		"GrugFar",
	},
}
