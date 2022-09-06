" nvim config
" author: @wojtii
set title
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
set tabstop=4
set softtabstop=4
set mouse=a
set clipboard=unnamedplus
set nowrap
set encoding=utf-8
set fileencoding=utf-8
set nocompatible
set wildmenu
set wildmode=longest:full,full
set scl=yes
set updatetime=200
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set hidden
set timeoutlen=250
set inccommand=nosplit
set laststatus=3
" TODO winbar (breadcrumbs) when 0.8 will be released

filetype plugin indent on

" highlight yanked
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup END

let mapleader = " "
let g:netrw_banner = 0
let &shell='/bin/zsh -i'

noremap Y y$ " yank to the end of line
nnoremap Q q " disable entering ex mode
nnoremap <Leader>fe :20Lexplore!<CR> " togle netrw on the right
nnoremap <M-Down> :resize -2<CR>
nnoremap <M-Up> :resize +2<CR>
nnoremap <M-Left> :vertical resize -2<CR>
nnoremap <M-Right> :vertical resize +2<CR>

" completion
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"
inoremap <C-Space> <C-n>

autocmd BufWritePre * %s/\s\+$//e " remove all trailing whitespace on save

set list listchars=tab:▸\ ,trail:·,space:·

" markdown
let g:markdown_fenced_languages = [
  \'bash=sh', 'css', 'go', 'html',
  \'javascript', 'js=javascript',
  \'json', 'python', 'sh', 'shell=sh',
  \'ts=typescript', 'typescript', 'yaml',
\]

call plug#begin('~/.config/nvim/plugged')
" theme
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" navigation
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'folke/which-key.nvim'

" editing
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()

" theme
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu
highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none

" lightline
let g:lightline = {
      \ 'colorscheme':'ayu',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }

" terminal
nnoremap <Leader>to :terminal<CR>
tnoremap <Esc> <C-\><C-n> " escape in terminal
lua <<EOF
require("toggleterm").setup{}
EOF
nnoremap <Leader>tv :ToggleTerm direction='vertical' size=40<CR>
nnoremap <Leader>th :ToggleTerm direction='horizontal'<CR>
nnoremap <Leader>tt :ToggleTerm direction='float'<CR>

lua << EOF
require("which-key").setup {}
EOF


" telescope
lua << EOF
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<S-Left>"] = require('telescope.actions').cycle_history_prev,
        ["<S-Right>"] = require('telescope.actions').cycle_history_next,
      },
    },
    path_display={"truncate"}
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    }
  },
}
EOF
nnoremap <Leader>p <cmd>Telescope find_files hidden=true<cr>
nnoremap <Leader>ff <cmd>Telescope live_grep<cr>
nnoremap <Leader>bb <cmd>Telescope buffers<cr>

" easymotion
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f)

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc", "tree-sitter-phpdoc" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

