-- Basics
local g = vim.g
g.mapleader = ' '
g.maplocalleader = ' '
g.netrw_banner = 0
g.netrw_browse_split = 4 -- open on the right side
g.netrw_winsize = 20

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
o.clipboard = 'unnamedplus' -- system clipboard
o.wrap = false
o.updatetime = 200
o.completeopt = 'menuone,noinsert,noselect'
o.laststatus = 3
o.scrolloff = 8
o.list = true
o.listchars = 'tab:▸ ,trail:·,space:·'
o.splitright = true
o.splitbelow = true
o.cursorline = true

local k = vim.keymap
k.set('', 'Y', 'y$', { noremap = true }) -- yank to the end of line
k.set('n', 'Q', 'q', { noremap = true }) -- disable entering ex mode
k.set('n', '<leader>fe', ':Lexplore!<CR>', { noremap = true }) -- togle netrw
k.set('n', '<M-Down>', ':resize -2<CR>', { noremap = true })
k.set('n', '<M-Up>', ':resize +2<CR>', { noremap = true })
k.set('n', '<M-Right>', ':vertical resize -2<CR>', { noremap = true })
k.set('n', '<M-Left>', ':vertical resize +2<CR>', { noremap = true })
k.set('n', '<leader>tt', ':FloatermToggle<CR>', { noremap = true })
k.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
k.set('n', '<leader>to', ':tabnew<CR>') -- open new tab
k.set('n', '<leader>tx', ':tabclose<CR>') -- close current tab
k.set('n', '<leader>tc', ':tabclose<CR>') -- close current tab
k.set('n', '<leader>tn', ':tabn<CR>') -- go to next tab
k.set('n', '<leader>tp', ':tabp<CR>') -- go to previous tab

vim.api.nvim_create_autocmd('TextYankPost', { -- highlight yanked
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
	end,
})


-- Bootstrap plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
	{ "folke/tokyonight.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	{ "nvim-mini/mini.nvim", version = false },
})

require("tokyonight").setup({
	style = "night",
	transparent = true,
})
vim.cmd [[colorscheme tokyonight]]

require("lualine").setup({
	options = {
		icons_enabled = false,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
			}
		}
	}
})

local opts = { noremap = true, silent = true }
k.set('n', '<space>e', vim.diagnostic.open_float, opts)
k.set('n', '[d', vim.diagnostic.goto_prev, opts)
k.set('n', ']d', vim.diagnostic.goto_next, opts)
k.set('n', '<space>q', vim.diagnostic.setloclist, opts)

require("mini.completion").setup()
k.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-y>"
  end
  return "<CR>"
end, { expr = true })

require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.surround").setup({
	mappings = {
		add = 'S',
	}
})
require("mini.jump2d").setup({
	mappings = {
		start_jumping = '<leader>s',
	},
})
require("mini.diff").setup()
k.set('n', '<leader>gd', MiniDiff.toggle_overlay)

local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<S-Left>"] = telescope_actions.cycle_history_prev,
				["<S-Right>"] = telescope_actions.cycle_history_next,
			},
		},
		path_display = { "truncate" }
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "-g", "!.git", "-L" },
			theme = "dropdown",
		},
		live_grep = {
			theme = "dropdown",
		},
		buffers = { 
			theme = "dropdown",
		}
	},
	extensions = {
		file_browser = {
			theme = "dropdown"
		},
	},
})
telescope.load_extension("file_browser")

local telescope_builtin = require("telescope.builtin")
k.set('n', '<leader>p', telescope_builtin.find_files, { noremap = true })
k.set('n', '<leader>ff', telescope_builtin.live_grep, { noremap = true })
k.set('n', '<leader>fb', telescope_builtin.buffers, { noremap = true })
k.set('n', '<leader>fh', telescope_builtin.help_tags, { noremap = true })
k.set('n', '<leader>fp', function() telescope.extensions.file_browser.file_browser({ disable_devicons = true }) end, { noremap = true })
k.set('n', '<leader>fc', function() telescope.extensions.file_browser.file_browser({ disable_devicons = true, path="%:p:h" }) end, { noremap = true })

