lua require('luadule')


nnoremap <leader>do :lua require('telescope.builtin').git_files({ cwd = "$HOME/dotfiles" })<CR>


nnoremap <leader>gb :lua require('telescope.builtin').git_branches({ initial_mode = 'normal' })<CR>
nnoremap <leader>gs :lua require('telescope.builtin').git_status({ initial_mode = 'normal' })<CR>
nnoremap <leader>of :lua require('telescope.builtin').oldfiles({ initial_mode = 'normal' })<CR>
