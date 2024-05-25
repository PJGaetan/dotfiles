return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"vrischmann/tree-sitter-templ",
		},
		build = ":TSUpdate",
		config = function()
			require("pjgaetan.treesitter")
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
	config = function()
		require("treesitter-context").setup({
			multiline_threshold = 3, -- Maximum number of lines to show for a single context
		})
	end,
}
