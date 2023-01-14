require('lazy').setup({
  'wbthomason/packer.nvim',

  'lspcontainers/lspcontainers.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'nvim-treesitter/nvim-treesitter',

  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp',
  'nvim-lua/lsp-status.nvim',
  'onsails/lspkind-nvim',
  'L3MON4D3/LuaSnip',

  'simrat39/rust-tools.nvim',
  'rust-lang/rust.vim',

  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-fzy-native.nvim',
  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  'kyazdani42/nvim-web-devicons',
  'preservim/nerdcommenter',
  'norcalli/nvim-terminal.lua',
  'tpope/vim-fugitive',
  'anott03/termight.nvim',

  -- 'hoob3rt/lualine.nvim',
  'luisiacc/gruvbox-baby',
  'tjdevries/colorbuddy.nvim',
})

require('a.plugins.telescope').setup()
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = "all"
})

RELOAD = require('plenary.reload').reload_module
