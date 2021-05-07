
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

" Coc Config
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-json', 'coc-yaml', 'coc-sql', 'coc-python', 'coc-prettier', 'coc-markdownlint', 'coc-elixir']
set statusline^=%{coc#status()}

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'preservim/nerdtree'

" Telescope
 if has('nvim')
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug '~/.config/nvim/plugin/telescope.vim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  " Plug 'neovim/nvim-lspconfig'
endif

" font and icone
Plug 'kyazdani42/nvim-web-devicons'

" jupyter-ascending
Plug 'untitled-ai/jupyter_ascending.vim'

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

" TODO: Pick a leader key
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

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

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
nnoremap <c-w>l :new

nnorema <leader>b :NERDTreeToggle<CR>
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

" telescope binding
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>

" jupyter ascending key binding
nmap <leader><leader>x <Plug>JupyterExecute
nmap <leader><leader>X <Plug>JupyterExecuteAll

" to past in visual mode without writing to register
vnoremap <leader>p "_dP

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
