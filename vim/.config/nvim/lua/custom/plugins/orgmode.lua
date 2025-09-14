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
			org_startup_folded = "showeverything",
			org_capture_templates = {},
			org_id_link_to_org_use_id = true,
			org_todo_keywords = { "TODO(t)", "NEXT(n)", "WAITING(w)", "|", "DONE(d)", "CANCELLED(c)" },
			mappings = {
				org = {
					org_open_at_point = "gf",
				},
				note = {
					org_note_kill = "Q",
				},
			},
		})
		-- foldlevel for non roam files is 2
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = { "*.org" },
			-- pattern = { vim.fn.expand("~/Jottacloud/orgfiles/**/*.org") }, --, "!~/Jottacloud/orgfiles/orgroam/**" },
			callback = function(args)
				local filepath = vim.fn.expand(args.file)
				local root = vim.fn.expand("~/Jottacloud/orgfiles/")
				local exclude = vim.fn.expand("~/Jottacloud/orgfiles/orgroam/")

				-- only act if file is under orgfiles but not under orgroam
				if filepath:find(root, 1, true) == 1 and filepath:find(exclude, 1, true) ~= 1 then
					vim.opt_local.foldlevel = 2
				end
			end,
		})
		-- carefull like to work/perso/interests files is hardcoded there
		require("pjgaetan.orgmenu")
	end,
}
