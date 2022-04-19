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

  -- TODO switch to galaxyline
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- colorschemes/themes
  use 'ayu-theme/ayu-vim'
  use 'kadekillary/Turtles'
  use 'tyrannicaltoucan/vim-deep-space'

  -- stuff requiring extra options
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }
end)

require('nvim-treesitter.configs').setup {
  -- Make sure these are installed
  ensure_installed = { "javascript", "typescript", "json", "html" },

  -- install parsers asynchronously
  sync_install = false,

  highlight = { enable = true }
}

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
