return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ "williamboman/mason.nvim",     lazy = false },
		"williamboman/mason-lspconfig.nvim",
		{ "barreiroleo/ltex-extra.nvim", ft = { "latex", "markdown", "tex" } },

		-- Additional lua configuration, makes nvim stuff amazing
		"folke/lazydev.nvim",
	},
	config = function()
		require("pjgaetan.lsp")
	end,
}
