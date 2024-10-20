return {
	-- null-ls for formatting
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("pjgaetan.format")
		end,
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
}
