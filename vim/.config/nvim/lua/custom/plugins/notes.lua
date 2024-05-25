return {
	{
		"epwalsh/obsidian.nvim",
		config = function()
			require("pjgaetan.obsidian")
		end,
	},
	"dhruvasagar/vim-table-mode",
	{
		"lervag/wiki.vim",
		config = function()
			-- Vim wiki setup
			vim.g.wiki_root = "~/wiki"
			vim.cmd([[
				let g:wiki_filetypes = ['md', 'wiki']
			]])
		end,
	},
	{ "lervag/wiki-ft.vim" },
	{
		"opdavies/toggle-checkbox.nvim",
		config = function()
			vim.keymap.set("n", "<leader><leader>t", require("toggle-checkbox").toggle)
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
