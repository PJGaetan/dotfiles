lua require('luadule')


nnoremap <leader>do :lua require('telescope.builtin').git_files({ cwd = "$HOME/dotfiles" })<CR>
nnoremap <leader>dg :lua require('telescope.builtin').live_grep({ cwd = "$HOME/dotfiles" })<CR>
nnoremap <leader>px :lua require('telescope.builtin').grep_string({search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })<CR>



nnoremap <leader>gb :lua require('telescope.builtin').git_branches({ initial_mode = 'normal' })<CR>
nnoremap <leader>gs :lua require('telescope.builtin').git_status({ initial_mode = 'normal' })<CR>
nnoremap <leader>of :lua require('telescope.builtin').oldfiles({ initial_mode = 'normal' })<CR>
