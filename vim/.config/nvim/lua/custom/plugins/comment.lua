return {
	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		config = function()
			-- Enable Comment.nvim
			require("Comment").setup()
			local ft = require("Comment.ft")
			ft
				-- Or set both line and block commentstring
				.set("sql", { "--%s", "--%s" })
				.set("dbt", { "--%s", "--%s" })
				.set("templ", { "<!-- %s -->", "<!-- %s -->" })
				.set("tf", { "# %s", "# %s" })
		end,
	},
}
