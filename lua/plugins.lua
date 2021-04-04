local vim = vim

local local_plugin = function(name)
  vim.cmd('set rtp+=$HOME/dev/nvim/' .. name)
end

-- local plugins
local_plugin('termight.nvim')
local_plugin('telescope.nvim')
local_plugin('plenary.nvim')
local_plugin('popup.nvim')
local_plugin('lsp-status.nvim')
local_plugin('harpoon')
local_plugin('telescope-frecency.nvim')
local_plugin('neovim-irc-ui')

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- nvim-lsp
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'tjdevries/lsp_extensions.nvim' use {'glepnir/lspsaga.nvim', branch = 'main'}
  -- other language suff
  use 'mattn/emmet-vim'
  use 'rust-lang/rust.vim'

  -- colorschemes
  use 'gruvbox-community/gruvbox'
  use 'joshdick/onedark.vim'
  use 'tjdevries/colorbuddy.vim'
  use 'tjdevries/gruvbuddy.nvim'

  -- utilities
  use 'preservim/nerdcommenter'
  use 'mbbill/undotree'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'
  use 'norcalli/nvim-terminal.lua'
  use 'mhinz/vim-startify'
  use 'vimwiki/vimwiki'

  use 'code-biscuits/nvim-biscuits'

  -- git
  use 'tpope/vim-fugitive'

  -- fun
  use 'ThePrimeagen/vim-be-good'
end)

-- initializing plugins
require('terminal').setup()
require('nvim-biscuits').setup({})
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained"
}
