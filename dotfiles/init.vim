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
set hidden

filetype plugin indent on

" highlight yanked
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
augroup END

let mapleader = " "
let g:netrw_banner = 0
let &shell='/bin/zsh -i'

noremap Y y$ " yank to the end of line
nnoremap Q q " disable entering ex mode
nnoremap <Leader>fe :Explore<CR> " open netrw
nnoremap <M-Down> :resize -2<CR>
nnoremap <M-Up> :resize +2<CR>
nnoremap <M-Left> :vertical resize -2<CR>
nnoremap <M-Right> :vertical resize +2<CR>

autocmd BufWritePre * %s/\s\+$//e " remove all trailing whitespace on save

set list listchars=tab:▸\ ,trail:·,space:·

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

" editing
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'

" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" theme
let ayucolor="mirage"
colorscheme ayu

" lightline
let g:lightline = { 'colorscheme':'ayu' }

" terminal
nnoremap <Leader>tt :terminal<CR>
tnoremap <Esc> <C-\><C-n> " escape in terminal
lua <<EOF
require("toggleterm").setup{}
EOF
nnoremap <Leader>tv :ToggleTerm direction='vertical' size=40<CR>
nnoremap <Leader>th :ToggleTerm direction='horizontal'<CR>
nnoremap <Leader>tf :ToggleTerm direction='float'<CR>
nnoremap <Leader>tq :ToggleTermCloseAll<CR>

" telescope
nnoremap <Leader>p <cmd>Telescope find_files<cr>
nnoremap <Leader>ff <cmd>Telescope live_grep<cr>
nnoremap <Leader>bb <cmd>Telescope buffers<cr>

" easymotion
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f2)

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" coc
let g:coc_global_extensions = [
    \'coc-css',
    \'coc-emmet',
    \'coc-eslint',
    \'coc-git',
    \'coc-go',
    \'coc-html',
    \'coc-json',
    \'coc-prettier',
    \'coc-pyright',
    \'coc-rls',
    \'coc-snippets',
    \'coc-tsserver',
    \'coc-yaml',
\]
" Trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
