set number
set linebreak
set termguicolors
set hlsearch
set smartcase
set ignorecase
set incsearch
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set mouse=a
set clipboard=unnamedplus
set nowrap
set encoding=utf-8
set fileencoding=utf-8
set nocompatible
set path+=**
set wildmenu
set nobackup
set ruler

syntax on
filetype plugin indent on

" yank to the end of line
noremap Y y$

" disable entering ex mode
nnoremap Q q

" automatically removing all trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

let g:netrw_banner = 0
