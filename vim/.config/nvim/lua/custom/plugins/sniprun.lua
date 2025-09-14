return {
	"michaelb/sniprun",
	build = "sh install.sh",
	config = function()
		require("sniprun").setup({
			display = {
				-- "Classic",
				-- "VirtualText",
				"Api",
			},
			selected_interpreters = { "Python3_fifo" },
			repl_enable = { "Python3_fifo" },
			-- show_no_output = {
			-- 	"Classic",
			-- },
			snipruncolors = {
				SniprunVirtualTextOk = { bg = "#808080", fg = "#000000", ctermbg = "Gray", ctermfg = "Black" },
				SniprunFloatingWinOk = { fg = "#808080", ctermfg = "Gray" },
				SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", ctermfg = "Black" },
				SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed", bold = true },
			},
		})
		vim.api.nvim_set_keymap("v", "<leader>r", "<Plug>SnipRun", { silent = true })
		vim.api.nvim_set_keymap("n", "<leader>r", "<Plug>SnipRun", { silent = true })
		vim.api.nvim_set_keymap("n", "<leader>f", "<Plug>SnipRunOperator", { silent = true })

		require("pjgaetan.sniprun")
	end,
}
