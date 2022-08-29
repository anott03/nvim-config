local vim = vim

local local_plugin = function(name)
  vim.cmd('set rtp+=$HOME/dev/nvim/' .. name)
end

require('packer').startup(function(use)
  local local_use = function(plugin)
   use(string.format("~/dev/nvim/%s", plugin))
  end

  use 'wbthomason/packer.nvim'

  local_use('lspcontainers.nvim')
  use 'nvim-lua/plenary.nvim'
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
  use 'nvim-treesitter/nvim-treesitter'
  use 'hoob3rt/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'preservim/nerdcommenter'
  use 'norcalli/nvim-terminal.lua'
  use 'tpope/vim-fugitive'
  use 'anott03/termight.nvim'

  use 'luisiacc/gruvbox-baby'
  use 'tjdevries/colorbuddy.nvim'
  use 'edeneast/nightfox.nvim'
  use 'Shatur/neovim-ayu'
  use 'folke/tokyonight.nvim'
end)

require('a.plugins.telescope').setup()
require('a.plugins.luasnip').setup()
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = "all"
})
require('ayu').setup({
  mirage = true,
  overrides = {},
})
RELOAD = require('plenary.reload').reload_module
