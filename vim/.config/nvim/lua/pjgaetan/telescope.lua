-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "vendor", "env", "node_modules" },
		layout_strategy = "vertical",
		layout_config = { width = 0.8, height = 0.95, preview_cutoff = 0 },
	},
	extensions = {
		repo = {
			list = {
				search_dirs = {
					"~/git",
				},
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
-- extension  repo
require("telescope").load_extension("repo")
vim.keymap.set("n", "<leader>l", require("telescope").extensions.repo.list)

-- gitmoji
vim.keymap.set("i", "<c-g><c-i>", function()
	require("telescope.builtin.").symbols(require("telescope.themes").get_cursor({}))
end)

-- select dir then grep inside dir in Telescope
require("dir-telescope").setup({
	hidden = true,
	no_ignore = false,
	show_preview = true,
})
require("telescope").load_extension("dir")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>sf", function()
	return require("telescope.builtin").find_files({ hidden = false })
end, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ff", function()
	return require("telescope.builtin").find_files(require("telescope.themes").get_ivy({}))
end)
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch [W]ord" })
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sdo", function()
	return require("telescope.builtin").find_files({ hidden = true, cwd = "~/dotfiles" })
end, { desc = "[S]earch [DO]tfiles" })

vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })

-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
-- vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
-- vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
