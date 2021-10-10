set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('luadule')
nnoremap <F4> :lua package.loaded.luadule = nil <cr>:source ~/.config/nvim/init.vim <cr>
