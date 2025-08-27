-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

local lga_actions = require("telescope-live-grep-args.actions")
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "vendor", "env", "node_modules" },
		layout_strategy = "vertical",
		layout_config = { width = 0.8, height = 0.95, preview_cutoff = 0 },
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			-- define mappings, e.g.
			mappings = { -- extend mappings
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- gitmoji
vim.keymap.set("i", "<c-g><c-i>", function()
	require("telescope.builtin.").symbols(require("telescope.themes").get_cursor({}))
end)

-- Grep in Dir
-- require("dir-telescope").setup({
-- 	hidden = true,
-- 	no_ignore = false,
-- 	show_preview = true,
-- })
-- require("telescope").load_extension("dir")
-- vim.keymap.set("n", "<leader>sd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })

--
vim.keymap.set("n", "<leader>si", function()
	require("telescope.builtin").find_files({
		attach_mappings = function(_, map)
			map("i", "asdf", function(_prompt_bufnr)
				print("You typed asdf")
			end)

			map({ "i", "n" }, "<C-r>", function(_prompt_bufnr)
				print("You typed <C-r>")
			end)

			-- needs to return true if you want to map default_mappings and
			-- false if not
			return true
		end,
	})
end, { desc = "[S]earch [I]inside" })

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>sf", function()
	return require("telescope.builtin").find_files({ hidden = false })
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>/", function()
	return require("telescope.builtin").live_grep({ search_dirs = { vim.fn.expand("%") } })
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>ff", function()
	return require("telescope.builtin").find_files(require("telescope.themes").get_ivy({}))
end)
vim.keymap.set(
	"n",
	"<leader>sg",
	":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "[S]earch by [G]rep" }
)
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch [W]ord" })

vim.keymap.set("n", "<leader>sdo", function()
	return require("telescope.builtin").find_files({ hidden = true, cwd = "~/dotfiles" })
end, { desc = "[S]earch [DO]tfiles" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")
	[1]
	if vim.v.shell_error ~= 0 then
		print("Not a git repository. Searching on current working directory")
		return cwd
	end
	return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require("telescope.builtin").live_grep({
			search_dirs = { git_root },
		})
	end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set(
	"n",
	"<leader>sd",
	require("telescope.builtin").lsp_document_symbols,
	{ desc = "[S]earch [D]ocument Symbols" }
)

vim.keymap.set("n", "<leader>sF", function()
	require("telescope.builtin").lsp_document_symbols({ symbols = { "Function", "Method" } })
end, { desc = "[S]earch [D]ocument Symbols" })

require("telescope").load_extension("orgmode")
vim.keymap.set("n", "<leader>rh", require("telescope").extensions.orgmode.refile_heading)
vim.keymap.set("n", "<leader>fh", require("telescope").extensions.orgmode.search_headings)
vim.keymap.set("n", "<leader>li", require("telescope").extensions.orgmode.insert_link)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "org",
	group = vim.api.nvim_create_augroup("orgmode_telescope_nvim", { clear = true }),
	callback = function()
		vim.keymap.set(
			"n",
			"<leader>or",
			require("telescope").extensions.orgmode.refile_heading,
			{ buffer = true, desc = "[O]rgmode [R]efile Heading" }
		)
	end,
})
