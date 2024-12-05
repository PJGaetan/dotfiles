vim.api.nvim_set_keymap("n", "<C-p>", ":lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":lua require('kulala').run()<CR>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>ci",
	"<cmd>lua require('kulala').from_curl()<cr>",
	{ noremap = true, silent = true, desc = "Paste curl from clipboard as http request" }
)
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>co",
	"<cmd>lua require('kulala').copy()<cr>",
	{ noremap = true, silent = true, desc = "Copy the current request as a curl command" }
)
