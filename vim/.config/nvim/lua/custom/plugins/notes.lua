return {
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		cmd = {
			"ObsidianToday",
			"ObsidianYesterday",
			"ObsidianSearch",
			"ObsidianQuickSwitch",
			"ObsidianLink",
			"ObsidianLinkNew",
			"ObsidianTemplate",
			"ObsidianFollowLink",
			"ObsidianWeekly",
			"ObsidianNew",
		},
		keys = {
			"<leader>npw",
			"<leader>nd",
			"<leader>ny",
			"<leader>ng",
			"<leader>ns",
			"<leader>nl",
			"<leader>nt",
			"<leader>no",
			"<leader>nw",
			"<leader>nc",
			"gf",
		},
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
