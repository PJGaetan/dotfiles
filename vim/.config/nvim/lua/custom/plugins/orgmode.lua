return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	dependencies = {
		{
			"akinsho/org-bullets.nvim",
			config = function()
				require("org-bullets").setup()
			end,
		},
	},
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			-- Uses nvim.intput.ui (or the layer built on top of it - snacks.nvim)
			-- ui = {
			-- 	input = {
			-- 		use_vim_ui = true,
			-- 	},
			-- },

			org_agenda_files = "~/Jottacloud/orgfiles/**/*",
			org_default_notes_file = "~/Jottacloud/orgfiles/refile.org",
			org_capture_templates = {},
			mappings = {
				note = {
					org_note_kill = "Q",
				},
			},
		})

		-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
		-- add ~org~ to ignore_install
		-- require('nvim-treesitter.configs').setup({
		--   ensure_installed = 'all',
		--   ignore_install = { 'org' },
		-- })

		-- TELESCOPE mapping in pjgaetan.telescope
	end,
}
