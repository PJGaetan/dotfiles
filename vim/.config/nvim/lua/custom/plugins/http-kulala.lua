return {
	-- HTTP REST-Client Interface
	"mistweaverco/kulala.nvim",
	config = function()
		vim.filetype.add({ extension = { http = "http" } })
		-- Setup is required, even if you don't pass any options
		require("kulala").setup({
			-- default_view, body or headers
			default_view = "body",
			-- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
			default_env = "dev",
			-- enable/disable debug mode
			debug = false,
			additional_curl_options = {},
			-- default formatters for different content types
			formatters = {
				json = { "jq", "." },
				xml = { "xmllint", "--format", "-" },
				html = { "xmllint", "--format", "--html", "-" },
			},
		})
	end,
	-- ft = { "http" },
}
