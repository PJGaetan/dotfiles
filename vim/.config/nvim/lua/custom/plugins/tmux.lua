return {
	-- send cmd from vim to tmux
	{
		"preservim/vimux",
		config = function()
			require("pjgaetan.tmux-vim")
		end,
	},
	-- vim tmux
	-- use { 'alexghergh/nvim-tmux-navigation' }
	{
		"mrjones2014/smart-splits.nvim",
		config = function()
			require("pjgaetan.layout")
		end,
	},
	{
		"jpalardy/vim-slime",
		config = function()
			-- vim slime
			vim.g.slime_target = "tmux"
			vim.g.slime_default_config = {
				socket_name = "default",
				target_pane = "{last}",
			}
			vim.g.slime_bracketed_paste = 1
			vim.g.slime_python_ipython = 1
		end,
	},
}
