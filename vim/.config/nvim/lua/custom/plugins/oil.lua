return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			columns = {
				-- "icon",
				-- "type",
				-- "permissions",
				-- "size",
				-- "mtime",
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
			keymaps = {
				["<C-h>"] = false,
			},
		})

		vim.keymap.set("n", "<leader>fe", require("oil").toggle_float)
		vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
	end,
}
