-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
-- <opt-j>
vim.keymap.set("n", "˙", require("smart-splits").resize_left)
vim.keymap.set("n", "∆", require("smart-splits").resize_down)
vim.keymap.set("n", "˚", require("smart-splits").resize_up)
vim.keymap.set("n", "¬", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

vim.keymap.set("n", "<leader>vs", "<cmd>vnew term://zsh<CR>")
vim.keymap.set("n", "<leader>hs", "<cmd>belowright new term://zsh<CR>")

-- mapping to easier navigate from terminal mode
vim.keymap.set("t", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("t", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("t", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("t", "<C-l>", require("smart-splits").move_cursor_right)
