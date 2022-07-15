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

autocmd BufWritePre * %s/\s\+$//e " remove all trailing whitespace on save

set list listchars=tab:▸\ ,trail:·,space:·

" markdown
let g:markdown_fenced_languages = [
  \'bash=sh',
  \'css',
  \'go',
  \'html',
  \'javascript',
  \'js=javascript',
  \'json',
  \'python',
  \'sh',
  \'shell=sh',
  \'ts=typescript',
  \'typescript',
  \'yaml',
\]

call plug#begin('~/.config/nvim/plugged')
" theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
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

" lsp
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

call plug#end()

" theme
let g:tokyonight_transparent="true"
colorscheme tokyonight

" lightline
let g:lightline = {
      \ 'colorscheme':'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'cocstatus' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
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
        ["<Left>"] = require('telescope.actions').cycle_history_prev,
        ["<Right>"] = require('telescope.actions').cycle_history_next,
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
nnoremap <Leader>p <cmd>Telescope find_files<cr>
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

" coc
" let g:coc_global_extensions = [
"   \'coc-css',
"   \'coc-emmet',
"   \'coc-eslint',
"   \'coc-git',
"   \'coc-go',
"   \'coc-html',
"   \'coc-json',
"   \'coc-pairs',
"   \'coc-prettier',
"   \'coc-pyright',
"   \'coc-rls',
"   \'coc-snippets',
"   \'coc-snippets',
"   \'coc-tsserver',
"   \'coc-yaml',
" \]
" " Trigger completion
" inoremap <silent><expr> <c-space> coc#refresh()
" " Show all diagnostics.
" nnoremap <silent><nowait> <Leader>cd :<C-u>CocList diagnostics<cr>
" " Show commands.
" nnoremap <silent><nowait> <Leader>cc :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <Leader>co  :<C-u>CocList outline<cr>
" " Code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <F2> <Plug>(coc-rename)
" nnoremap <silent> gh :call <SID>show_documentation()<CR>
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction
" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" " Add missing imports in go on save
" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" nvim lsp
lua << EOF

local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp',},
--    {name = 'buffer', keyword_length = 3},
--    {name = 'luasnip', keyword_length = 2},
  },
})

local saga = require('lspsaga')
saga.init_lsp_saga()

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<Leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gh', require('lspsaga.hover').render_hover_doc, { silent = true })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gs', require("lspsaga.signaturehelp").signature_help, { silent = true,noremap = true})
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        gopls = {
            gofumpt = true
        }
    }
}
EOF

autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
