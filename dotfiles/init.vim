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

" completion
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" TODO linting

"git
Plug 'airblade/vim-gitgutter'
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

" lsp from https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
lua <<EOF
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Completion
  require'completion'.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Format on save
  vim.api.nvim_command("au BufWritePost <buffer> lua vim.lsp.buf.formatting()")

-- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'gopls',
  'pyright',
  'tsserver',
  'graphql'
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF

