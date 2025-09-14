return {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"folke/lazydev.nvim",
	},
	config = function()
		require("pjgaetan.lsp")
	end,
}
