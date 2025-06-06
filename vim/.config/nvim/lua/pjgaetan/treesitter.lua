local M = {}
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
M.setup = function()
	require("nvim-treesitter.configs").setup({
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = {
			"c",
			"cpp",
			"go",
			"lua",
			"python",
			"rust",
			"typescript",
			"terraform",
			"markdown",
			"markdown_inline",
			"json",
			"svelte",
			"css",
			"html",
			"http",
			"javascript",
			"sql",
			"vimdoc",
			"toml",
			"templ",
			"yaml",
			"htmldjango",
		},
		-- If error, use this cmd and ensure only the treesitter one is used
		-- echo nvim_get_runtime_file('parser', v:true)

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "markdown" },
			disable = { "txt" }, -- list of language that will be disabled
		},
		indent = { enable = true, disable = { "python" } },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = "<c-s>",
				node_decremental = "<c-backspace>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	})

	local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	treesitter_parser_config.templ = {
		install_info = {
			url = "https://github.com/vrischmann/tree-sitter-templ.git",
			files = { "src/parser.c", "src/scanner.c" },
			branch = "master",
		},
	}

	treesitter_parser_config.gotmpl = {
		install_info = {
			url = "https://github.com/ngalaiko/tree-sitter-go-template",
			files = { "src/parser.c" },
		},
		filetype = "gotmpl",
		used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
	}

	vim.treesitter.language.register("templ", "templ")
	vim.treesitter.language.register("yaml", "ymlj2")
end

M.setup()

return M
