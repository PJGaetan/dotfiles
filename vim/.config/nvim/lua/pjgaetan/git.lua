-- git worktree
require("telescope").load_extension("git_worktree")
vim.keymap.set("n", "<leader>gw", require("telescope").extensions.git_worktree.git_worktrees)
vim.keymap.set("n", "<leader>gcw", require("telescope").extensions.git_worktree.create_git_worktree)

-- git remap
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>0Gclog<CR>")

-- Gitsigns
-- See `:help gitsigns.txt`
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

vim.keymap.set("v", "<leader>ga", function()
	require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end)
vim.keymap.set("v", "<leader>gr", function()
	require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end)

vim.keymap.set("n", "<leader>gp", require("gitsigns").preview_hunk_inline)
vim.keymap.set("n", "<leader>ga", require("gitsigns").stage_hunk)
vim.keymap.set("n", "<leader>gr", require("gitsigns").reset_hunk)
