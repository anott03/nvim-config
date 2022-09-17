local vim = vim

local local_plugin = function(name)
  vim.cmd('set rtp+=$HOME/dev/nvim/' .. name)
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'lspcontainers/lspcontainers.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-treesitter/nvim-treesitter'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'onsails/lspkind-nvim'
  use 'L3MON4D3/LuaSnip'

  use 'rust-lang/rust.vim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'kyazdani42/nvim-web-devicons'
  use 'preservim/nerdcommenter'
  use 'norcalli/nvim-terminal.lua'
  use 'tpope/vim-fugitive'
  use 'anott03/termight.nvim'

  use 'hoob3rt/lualine.nvim'
  use 'luisiacc/gruvbox-baby'
  use 'tjdevries/colorbuddy.nvim'
end)

require('a.plugins.telescope').setup()
require('a.plugins.luasnip').setup()
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = "all"
})
-- require('ayu').setup({
  -- mirage = true,
  -- overrides = {},
-- })
RELOAD = require('plenary.reload').reload_module
