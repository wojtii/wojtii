set number
set linebreak
set scrolloff=100
set showmatch
set termguicolors
set hlsearch
set smartcase
set ignorecase
set incsearch
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set ruler
set mouse=a
set clipboard=unnamedplus
set nowrap
set encoding=utf-8
set fileencoding=utf-8
set nocompatible
set path+=**
set wildmenu
set nobackup

syntax on
filetype plugin indent on

" yank to the end of line
noremap Y y$

" disable entering ex mode
nnoremap Q q

" remember last position
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" automatically removing all trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

