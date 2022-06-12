
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

" tree explorer
Plug 'preservim/nerdtree'

" Config python for lsp :help provider-python (virtualenv section)
let g:python3_host_prog = '/Users/GaetanPJ/.pyenv/versions/py3nvim/bin/python'


" Telescope
 if has('nvim')
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug '~/.config/nvim/plugin/telescope.vim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'nvim-treesitter/playground'
  " Plug 'neovim/nvim-lspconfig'
  "Plug 'lewis6991/gitsigns.nvim'
  Plug 'tpope/vim-commentary'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'camgraff/telescope-tmux.nvim'
endif

" lsp mapping

if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
nmap gr <Plug>(lsp-references)
nmap gi <Plug>(lsp-implementation)
nmap gt <Plug>(lsp-type-definition)
nmap <leader>rn <Plug>(lsp-rename)
nmap [g <Plug>(lsp-previous-diagnostic)
nmap ]g <Plug>(lsp-next-diagnostic)
nmap K <Plug>(lsp-hover)
nmap gd    <Plug>(lsp-definition)

let g:lsp_format_sync_timeout = 1000
autocmd! BufWritePre *.rs,*.go,*.py call execute('LspDocumentFormatSync')

" quickfixlist
nmap <C-j> :cnext <CR>
nmap <C-k> :cprev <CR>
nmap <leader>qq :cclose <CR>
    

" font and icone
Plug 'kyazdani42/nvim-web-devicons'

" jupyter-ascending
" Plug 'untitled-ai/jupyter_ascending.vim'
" Plug 'jupyter-vim/jupyter-vim'



Plug 'tpope/vim-surround'

" Vim git
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
" set updatetime=100

" Start menu 
Plug 'mhinz/vim-startify'


" set Vim-specific sequences for RGB colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set background=dark
let g:dracula_colorterm = 0"
packadd! dracula
colorscheme dracula

" Turn on syntax highlighting
syntax enable

" For plugins to load correctly
filetype plugin indent on

" Pick a leader key
let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim


" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
" nnoremap / /\v
" vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Remap move between buffer
" nnoremap <c-w>l :new

nnoremap <leader>b :NERDTreeToggleVCS<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" jupyter ascending key binding
nmap <leader><leader>x <Plug>JupyterExecute
nmap <leader><leader>X <Plug>JupyterExecuteAll

" to past in visual mode without writing to register
vnoremap <leader>p "_dP

" open terminal inside vim
map <leader>tt :vnew term://zsh<CR>

" Toggle hybride mode 
" turn it of in insert and focus off
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" All of your Plugins must be added before the following line 
call plug#end()
filetype plugin indent on " required
