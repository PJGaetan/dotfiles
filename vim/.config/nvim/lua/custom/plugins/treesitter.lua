return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
			{ "vrischmann/tree-sitter-templ",                lazy = true, filetype = "templ" },
		},
		build = ":TSUpdate",
		config = function()
			require("pjgaetan.treesitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				multiline_threshold = 3, -- Maximum number of lines to show for a single context
				on_attach = function(bufnr)
					-- get filetype from buffer
					local ft = vim.bo[bufnr].filetype
					if ft == "markdown" then
						return false
					else
						return true
					end
				end,
			})
		end,
	},
}
