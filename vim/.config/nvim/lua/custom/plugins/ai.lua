return {
	-- code prediction a la copilote
	{
		"Exafunction/codeium.vim",
		config = function()
			-- codeium configuration
			vim.g.codeium_manual = false
			vim.keymap.set("i", "\t", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })

			vim.keymap.set("n", "<leader>tc", "<cmd>CodeiumToggle<CR>")
			vim.keymap.set("i", "<C-o>", "<cmd>CodeiumToggle<CR>")

			vim.g.codeium_filetypes = {
				lua = true,
				markdown = false,
				json = false,
				rust = true,
				python = true,
				javascript = true,
				go = true,
				["grug-far"] = false,
			}
		end,
	},
}
