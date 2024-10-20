vim.api.nvim_set_keymap("n", "<C-p>", ":lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":lua require('kulala').run()<CR>", { noremap = true, silent = true })
