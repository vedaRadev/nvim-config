local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    -- colorschemes/themes
    'ayu-theme/ayu-vim',
    'kadekillary/Turtles',
    'tyrannicaltoucan/vim-deep-space',
    'folke/tokyonight.nvim',
    { 'pineapplegiant/spaceduck', branch = 'main' },
    'tiagovla/tokyodark.nvim',
    'chase/focuspoint-vim',
    'NLKNguyen/papercolor-theme',
    'christophermca/meta5',
    'TheNiteCoder/mountaineer.vim',
    'fcpg/vim-orbital',
    'jaredgorski/SpaceCamp',
    'tomasr/molokai',
    'srcery-colors/srcery-vim',
    'fenetikm/falcon',
    'AlessandroYorba/Alduin',
    'stankovictab/mgz.nvim',
    'Aryansh-S/fastdark.vim',
    'gtr/rza',

    -- plugins
    'tpope/vim-fugitive',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-commentary',
    't9md/vim-choosewin',
    'andrewradev/splitjoin.vim',
    'junegunn/goyo.vim',
    'junegunn/vim-peekaboo',
    'godlygeek/tabular',
    'scrooloose/nerdtree',
    'norcalli/nvim-colorizer.lua',
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig'
    },

    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    },

    {
        'iamcco/markdown-preview.nvim',
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'octaltree/cmp-look',
            'dcampos/nvim-snippy',
            'dcampos/cmp-snippy',
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "rust", "lua" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        }
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
    },

})

-- require('bufferline').setup{
--     options = {
--         mode = 'tabs',
--         diagnostics = 'nvim_lsp'
--     }
-- }

--require('lualine').setup(require('lualine.evil-lualine'))
local function get_active_lsp()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_clients()

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
        theme = '16color',
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

-- require('nvim-treesitter.configs').setup {
--     ensure_installed = 'all',

--     -- install parsers asynchronously
--     sync_install = true,

--     highlight = { enable = true },
--     indent = { enable = true },
-- }

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
    capabilities = require('cmp_nvim_lsp').default_capabilities(
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
lspconfig.cssls.setup({})
lspconfig.eslint.setup({})
-- lspconfig.lua_ls.setup({})
lspconfig.html.setup({})
lspconfig.clangd.setup({})
lspconfig.jsonls.setup({})
lspconfig.yamlls.setup({})
lspconfig.bashls.setup({})
-- lspconfig.groovyls.setup({})
-- lspconfig.sqlls.setup({})
lspconfig.gdscript.setup({})
-- lspconfig.csharp_ls.setup({})
lspconfig.rust_analyzer.setup({
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                allFeatures = true,
                overrideCommand = {
                    'cargo', 'clippy', '--workspace', '--message-format=json',
                    '--all-targets', '--all-features'
                }
            }
        }
    }
})

vim.g['choosewin_overlay_enable'] = 1

vim.g['NERDTreeAutoCenter'] = 0

vim.g['peekaboo_window'] = 'vert bo 50new'
vim.g['peekaboo_delay'] = 500

vim.cmd[[ au FileType c,cpp,cs setlocal commentstring=//%s ]]
