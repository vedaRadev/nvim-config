require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'glepnir/dashboard-nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 't9md/vim-choosewin'
  use 'andrewradev/splitjoin.vim'
  use 'junegunn/goyo.vim'
  use 'junegunn/vim-peekaboo'
  use 'godlygeek/tabular'
  use 'scrooloose/nerdtree'
  use 'norcalli/nvim-colorizer.lua'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-calc',
			'f3fora/cmp-spell',
			'octaltree/cmp-look',

			'dcampos/nvim-snippy',
			'dcampos/cmp-snippy',
			-- 'hrsh7th/vim-vsnip',
			-- 'hrsh7th/cmp-vsnip',

		},
	}

	-- TODO check if we're on windows and use the windows-specific install for tabnine
	use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
	-- windows version below
	-- use { 'tzachar/cmp-tabnine, after = 'nvim-cmp', run = 'powershell ./install.ps1', requires = 'hrsh7th/nvim-cmp' }

  -- colorschemes/themes
  use 'ayu-theme/ayu-vim'
  use 'kadekillary/Turtles'
  use 'tyrannicaltoucan/vim-deep-space'
  use 'folke/tokyonight.nvim'

  -- stuff requiring extra options
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)

-- local lualine_config = require('lualine.evil-lualine')
require('lualine').setup(require('lualine.evil-lualine'))
-- require('lualine').setup{ options = { theme = 'ayu_dark' } }

require('nvim-treesitter.configs').setup {
  -- Make sure these are installed
  ensure_installed = 'all',

  -- install parsers asynchronously
  sync_install = false,

  highlight = { enable = true },
  indent = { enable = true },
}

local cmp = require('cmp')
cmp.setup {
	snippet = {
		expand = function(args)
			-- vim.fn['vsnip#anonymous'](args.body)
			require('snippy').expand_snippet(args.body)
		end
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-f'] = cmp.mapping.scroll_docs(-4),
		['<C-b>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-a>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- accept currently selected item. set "select" to false to only confirm explicitly selected items
	}),
	sources = cmp.config.sources(
		{
			{ name = 'nvim_lsp' },
			{ name = 'cmp_tabnine' },
			{ name = 'snippy' },
			-- { name = 'vsnip' }
		},
		{
			{ name = 'buffer' },
		}
	),
}

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = 'buffer' } }
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ update_in_insert = false }
)

local cmp_lsp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('nvim-lsp-installer').on_server_ready(function(server)
  server:setup { capabilities = cmp_lsp_capabilities }
end)

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.g.dashboard_default_executive = 'telescope'

vim.g['airline_powerline_fonts'] = 0 -- pretty airline with powerline fonts
vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline_theme'] = 'turtles'
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_section_b'] = '%{strftime("%H:%M")}'

vim.g['choosewin_overlay_enable'] = 1

vim.g['NERDTreeAutoCenter'] = 0

vim.g['peekaboo_window'] = 'vert bo 50new'
vim.g['peekaboo_delay'] = 500
