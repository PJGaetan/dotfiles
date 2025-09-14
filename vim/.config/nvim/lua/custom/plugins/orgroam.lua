return {
	"chipsenkbeil/org-roam.nvim",
	dependencies = {
		{
			"nvim-orgmode/orgmode",
		},
	},
	ft = { "org" },
	keys = { "<leader>nf", "<leader>nc" },
	config = function()
		require("org-roam").setup({
			directory = "~/Jottacloud/orgfiles/orgroam/",
			-- optional
			org_files = {
				"~/Jottacloud/orgfiles/*.org",
			},
			bindings = {
				add_alias = "<leader>naa",
				add_origin = "<leader>nao",
				remove_alias = "<leader>nra",
				remove_origin = "<leader>nro",
			},
			extensions = {
				dailies = {
					bindings = false,
				},
			},
		})
	end,
}
