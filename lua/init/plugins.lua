local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	'tpope/vim-fugitive',
	'tpope/vim-surround',
	'tpope/vim-repeat',
	'tpope/vim-commentary',
	'andrewradev/splitjoin.vim',
	'godlygeek/tabular',
	'scrooloose/nerdtree',
	'tpope/vim-abolish',

	-- For managing tree-sitter parsers
	-- NOTE: Must have tree-sitter-cli installed on machine
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter-cli locally
		config = function()
			require("tree-sitter-manager").setup({
				-- ensure_installed = {}, -- I'll just do this manually
				-- languages = {}, -- For overriding or adding new parser sources
				highlight = true, -- enable highlighting by default
			})
		end
	},

	-- LSP package manager, automatic enabling of LSP clients
	-- based on filetype
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig"
		},
	},

	-- LuaLS autosetup
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			-- Load luvit types when vim.uv word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		}
	},

	{
		'mbbill/undotree',
		config = function()
			vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
		end
	},

	{
		'machakann/vim-highlightedyank',
		config = function()
			vim.g['highlightedyank_highlight_duration'] = 350
		end
	},

	{
		'nvim-mini/mini.align',
		version = false,
		config = function()
			require("mini.align").setup {
				mappings = {
					start = ' a',
					start_with_preview = ' A',
				}
			}
		end
	},

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup {}
		end
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'dcampos/nvim-snippy',
			'dcampos/cmp-snippy',
		},
		config = function()
			local cmp = require('cmp')
			cmp.setup {
				completion = {
					autocomplete = false
				},
				snippet = {
					expand = function(args)
						require('snippy').expand_snippet(args.body)
					end
				},
				window = {
					-- TODO(ryan): customization if desired
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
		end
	},

	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = vim.fn.has('win32') == 1 and 'wsl make' or 'make',
			}
		}
	},

	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
	},

	{
		'mrcjkb/rustaceanvim',
		version = '^8',
		lazy = false, -- plugin already lazy
	},
})

local function get_active_lsp()
	local msg = 'No Active Lsp'
	local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	if next(clients) == nil then return msg end

	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end

	return msg
end

local function lsp_reporter()
	return 'LSP: ' .. get_active_lsp()
end

require('lualine').setup{
	options = {
		theme = 'powerline_dark',
		icons_enabled = false,
		component_separators = { left = '|', right = '|' },
		section_separators = { left = '', right = '' },
		always_divide_middle = false,
		globalstatus = false,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'filename', lsp_reporter, 'encoding' },
		lualine_c = {
			{
				'branch',
				separator = ''
			},
			{
				'diff',
				separator = '',
				colored = true,
				diff_color = {
					added = { fg = 'lawngreen', bg = 'black' },
					modified = { fg = 'darkorange', bg = 'black' },
					removed = { fg = 'red', bg = 'black' },
				},
			},
			'diagnostics',
		},
		lualine_x = {},
		lualine_y = { 'searchcount', 'selectioncount' },
		lualine_z = { 'location', 'progress' },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	}
}

-- NOTE: Not needed with tree-sitter-manager and "highlight = true"
-- -- start treesitter highlighting automatically when filetype is recognized
-- vim.api.nvim_create_autocmd('FileType', {
-- 	pattern = { '*' },
-- 	callback = function()
-- 		-- FIXME find a better way to do this
-- 		-- maybe there's a way to check if we have a parser installed before trying to start it
-- 		pcall(vim.treesitter.start)
-- 	end,
-- })

vim.lsp.config('asm_lsp', {
	filetype = { 'asm', 'nasm' }
})

vim.g['choosewin_overlay_enable'] = 1

vim.g['NERDTreeAutoCenter'] = 0

vim.cmd[[ au FileType c,cpp,cs setlocal commentstring=//%s ]]
