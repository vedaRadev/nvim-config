require('packer').startup(function()
  -- TODO set up these plugins
  -- use 'jbyuki/venn.nvim' -- ascii diagrams

  use 'wbthomason/packer.nvim'
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
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig'
  }

  use {
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = 'markdown',
  }

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
		},
	}

  use { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' }

	-- TODO check if we're on windows and use the windows-specific install for tabnine
	-- use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
	-- windows version below
	-- use { 'tzachar/cmp-tabnine, after = 'nvim-cmp', run = 'powershell ./install.ps1', requires = 'hrsh7th/nvim-cmp' }

  -- colorschemes/themes
  use 'ayu-theme/ayu-vim'
  use 'kadekillary/Turtles'
  use 'tyrannicaltoucan/vim-deep-space'
  use 'folke/tokyonight.nvim'
  use { 'pineapplegiant/spaceduck', branch = 'main' }
  use 'tiagovla/tokyodark.nvim'

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

require('bufferline').setup{
  options = {
    mode = 'tabs',
    diagnostics = 'nvim_lsp'
  }
}

-- local lualine_config = require('lualine.evil-lualine')
require('lualine').setup(require('lualine.evil-lualine'))
-- require('lualine').setup{ options = { theme = 'ayu_dark' } }

require('nvim-treesitter.configs').setup {
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
			-- { name = 'cmp_tabnine' },
			{ name = 'snippy' },
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

-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
local lsp_defaults = {
  flags = {
    debounce_text_changes = 150
  },
  capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  on_attach = function(client, buffer_number)
    vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
  end
}

local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

require('mason').setup()
require('mason-lspconfig').setup()
lspconfig.tsserver.setup({})
lspconfig.sumneko_lua.setup({})
lspconfig.html.setup({})
lspconfig.clangd.setup({})
lspconfig.jsonls.setup({})
lspconfig.yamlls.setup({})
lspconfig.bashls.setup({})

vim.g['airline_powerline_fonts'] = 0 -- pretty airline with powerline fonts
vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline_theme'] = 'turtles'
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_section_b'] = '%{strftime("%H:%M")}'

vim.g['choosewin_overlay_enable'] = 1

vim.g['NERDTreeAutoCenter'] = 0

vim.g['peekaboo_window'] = 'vert bo 50new'
vim.g['peekaboo_delay'] = 500

vim.cmd[[ au FileType c,cpp setlocal commentstring=//%s ]]
