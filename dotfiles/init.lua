-- Basics
local g = vim.g
g.mapleader = ' '
g.maplocalleader = ' '
g.netrw_banner = 0

local wo = vim.wo
wo.number = true
wo.signcolumn = 'yes'

local o = vim.opt
o.title = true
o.termguicolors = true
o.smartcase = true
o.ignorecase = true
o.smartindent = true
o.smarttab = true
o.tabstop = 4
o.shiftwidth = 4
o.clipboard:append { 'unnamedplus' } -- system clipboard
o.wrap = false
o.updatetime = 200
o.completeopt = 'menuone,noinsert,noselect'
o.laststatus = 3
o.scrolloff = 10
o.list = true
o.listchars = 'tab:▸ ,trail:·,space:·'
o.splitright = true
o.splitbelow = true

local k = vim.keymap
k.set('', 'Y', 'y$', { noremap = true }) -- yank to the end of line
k.set('n', 'Q', 'q', { noremap = true }) -- disable entering ex mode
k.set('n', '<Leader>e', ':20Lexplore!<CR>', { noremap = true }) -- togle netrw on the right
k.set('n', '<M-Down>', ':resize -2<CR>', { noremap = true })
k.set('n', '<M-Up>', ':resize +2<CR>', { noremap = true })
k.set('n', '<M-Left>', ':vertical resize -2<CR>', { noremap = true })
k.set('n', '<M-Right>', ':vertical resize +2<CR>', { noremap = true })
k.set('n', '<Leader>tt', ':FloatermToggle<CR>', { noremap = true })
k.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
k.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
k.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
k.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
k.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

vim.api.nvim_create_autocmd('TextYankPost', { -- highlight yanked
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
	end,
})

-- Plugins
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'voldikss/vim-floaterm'
	use 'lewis6991/gitsigns.nvim'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'

	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use "rafamadriz/friendly-snippets"
	use "mfussenegger/nvim-lint"
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	use "folke/which-key.nvim"

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use 'nvim-telescope/telescope-file-browser.nvim'

	-- editing
	use "windwp/nvim-autopairs"
	use "kylechui/nvim-surround"
	use "easymotion/vim-easymotion"
	use 'numToStr/Comment.nvim'
end)

-- Theme
require("tokyonight").setup({
	style = "night",
	transparent = true,
})
vim.cmd [[colorscheme tokyonight]]

require('lualine').setup({
	options = {
		icons_enabled = false,
		component_separators = { left = '|', right = '|' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_c = {
			{
				'filename',
				file_status = true,
				path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
			}
		}
	}
})

require('gitsigns').setup({
	current_line_blame = false,
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	local telescopeb = require 'telescope.builtin'
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', telescopeb.lsp_references, bufopts)
	vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format { async = true } end, bufopts)

	vim.keymap.set('n', '<leader>cs', telescopeb.lsp_document_symbols, bufopts)
	vim.keymap.set('n', '<leader>cd', telescopeb.diagnostics, bufopts)
end

local cmp = require 'cmp'
cmp.setup({
	snippet = {
		expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs( -4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources(
		{
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' },
		},
		{ { name = 'buffer' } },
		{ { name = 'path' } }
	)
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = require('lspconfig')

lsp.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		gopls = {
			gofumpt = true
		}
	}
})

lsp.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { 'vim' } }
		}
	}
})

-- format on save - not working currently
-- vim.cmd('autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()')

require('lint').linters_by_ft = {
	go = { 'golangcilint', }
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function() require("lint").try_lint() end,
})

require 'nvim-treesitter.configs'.setup({
	ensure_installed = "all",
	highlight = { enable = true },
})

require("which-key").setup({})

require('telescope').setup({
	defaults = {
		mappings = {
			i = {
				["<S-Left>"] = require('telescope.actions').cycle_history_prev,
				["<S-Right>"] = require('telescope.actions').cycle_history_next,
			},
		},
		path_display = { "truncate" }
	},
	pickers = {
		find_files = {
			find_command = { 'rg', '--files', '--hidden', '-g', '!.git', '-L' },
			theme = "dropdown",
		},
		live_grep = { theme = "dropdown", },
		buffers = { theme = "dropdown", }
	},
	extensions = { file_browser = { theme = "dropdown", },
	},
})
require("telescope").load_extension "file_browser"

k.set('n', '<Leader>p', '<cmd>Telescope find_files <CR>', { noremap = true })
k.set('n', '<Leader>ff', '<cmd>Telescope live_grep <CR>', { noremap = true })
k.set('n', '<Leader>bb', '<cmd>Telescope buffers <CR>', { noremap = true })
k.set('n', '<Leader>fh', '<cmd>Telescope help_tags <CR>', { noremap = true })
k.set('n', '<Leader>fb', ':Telescope file_browser disable_devicons=true <CR>', { noremap = true })
k.set('n', '<Leader>fe', ':Telescope file_browser disable_devicons=true file_browser path=%:p:h <CR>', { noremap = true })

require("nvim-autopairs").setup {}
require("nvim-surround").setup {}
k.set('n', '<Leader>s', '<Plug>(easymotion-overwin-f)')
k.set('n', '<leader><leader>s', '<Plug>(easymotion-overwin-f)')

require('Comment').setup()
