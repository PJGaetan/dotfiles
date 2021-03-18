lua require('luadule')


nnoremap <leader>vic :lua require('telescope.builtin').find_files({ cwd = "$HOME/.config/nvim/" })<CR>


nnoremap <leader>gb :lua require('telescope.builtin').git_branches({ initial_mode = 'normal' })<CR>
nnoremap <leader>gs :lua require('telescope.builtin').git_status({ initial_mode = 'normal' })<CR>
nnoremap <leader>of :lua require('telescope.builtin').oldfiles({ initial_mode = 'normal' })<CR>
