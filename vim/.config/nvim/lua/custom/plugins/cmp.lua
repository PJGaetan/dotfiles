return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"folke/lazydev.nvim",
		"github/copilot.vim",
		-- "zbirenbaum/copilot.lua",
		-- "zbirenbaum/copilot-cmp",
		-- {
		-- 	"Exafunction/codeium.vim",
		-- 	dependencies = {
		-- 		"nvim-lua/plenary.nvim",
		-- 	},
		-- 	commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2",
		-- 	-- code prediction a la copilote
		-- 	config = function()
		-- 		vim.keymap.set("i", "\t", function()
		-- 			return vim.fn["codeium#Accept"]()
		-- 		end, { expr = true })
		--
		-- 		vim.keymap.set("n", "<leader>tc", "<cmd>CodeiumToggle<CR>")
		-- 		vim.keymap.set("i", "<C-o>", "<cmd>CodeiumToggle<CR>")
		--
		-- 		vim.g.codeium_filetypes = {
		-- 			lua = true,
		-- 			bash = true,
		-- 			zsh = true,
		-- 			markdown = false,
		-- 			json = false,
		-- 			rust = true,
		-- 			python = true,
		-- 			javascript = true,
		-- 			go = true,
		-- 			["grug-far"] = false,
		-- 		}
		-- 	end,
		-- },
	},
	config = function()
		require("pjgaetan.cmp")
	end,
}
