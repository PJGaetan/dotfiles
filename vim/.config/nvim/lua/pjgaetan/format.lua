-- null-ls for formatting
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
	sources = {
		null_ls.builtins.formatting.terraform_fmt.with({
			filetypes = { "terraform", "tf", "hcl" },
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.codespell.with({
			filetypes = { "lua", "markdown", "hcl" },
		}),
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.formatting.rustfmt.with({
			filetypes = { "rust" },
		}),
		null_ls.builtins.formatting.prettier.with({
			filetypes = {
				"javascript",
				"typescript",
				"css",
				"scss",
				"html",
				"json",
				"yaml",
				-- "markdown",
				-- "graphql",
				-- "md",
				"txt",
			},
		}),

		-- null_ls.builtins.formatting.sqlfmt,
		null_ls.builtins.diagnostics.sqlfluff.with({
			extra_args = { "--dialect", "snowflake" },
		}),
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.diagnostics.shellcheck.with({
			diagnostics_format = "#{m} [#{c}]",
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})