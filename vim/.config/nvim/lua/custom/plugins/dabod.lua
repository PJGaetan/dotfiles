return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "dbt" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DB",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1

			vim.g.dbs = {
				{
					name = "snowflake",
					url = "snowflake://gaetan.pierrejustin%40vista.com@vistaprint.eu-west-1/SANDBOX?authenticator=externalbrowser",
				},
			}
		end,
	},
}
