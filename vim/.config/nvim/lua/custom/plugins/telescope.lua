return {
	{ "olacin/telescope-gitmoji.nvim" },
	{ "princejoogie/dir-telescope.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{
				"nvim-orgmode/telescope-orgmode.nvim",
				event = "VeryLazy",
				dependencies = {
					"nvim-orgmode/orgmode",
					"nvim-telescope/telescope.nvim",
				},
			},
		},
		lazy = false,
		config = function()
			require("telescope").load_extension("live_grep_args")
			require("pjgaetan.telescope")
		end,
	},
}
