-- local plugins so that I can work on them
local vim = vim
local local_plugin = function(name) vim.cmd('set rtp+=$HOME/dev/nvim/' .. name) end
local_plugin('termight.nvim')
local_plugin('telescope.nvim')
local_plugin('plenary.nvim')
local_plugin('popup.nvim')
local_plugin('lsp-status.nvim')
local_plugin('harpoon')
local_plugin('telescope-frecency.nvim')
local_plugin('hop.nvim')
local_plugin('neovim-irc-ui')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neoclide/vim-jsx-improve'
  use 'anott03/vim-react-snippets'
  use 'mattn/emmet-vim'
  use 'rust-lang/rust.vim'
  use {'glepnir/lspsaga.nvim', branch = 'main'}

  -- nvim-lsp
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'tjdevries/lsp_extensions.nvim'

  -- colorschemes
  use 'gruvbox-community/gruvbox'
  use 'joshdick/onedark.vim'
  use 'tjdevries/colorbuddy.vim'
  use 'tjdevries/gruvbuddy.nvim'
  use 'neoclide/coc.nvim'

  -- utilities
  use 'preservim/nerdcommenter'
  use 'nvim-lua/popup.nvim'
  use 'mbbill/undotree'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'
  use 'norcalli/nvim-terminal.lua'
  use 'mhinz/vim-startify'
  use 'tjdevries/express_line.nvim'
  use 'vimwiki/vimwiki'

  -- git
  use 'tpope/vim-fugitive'
  use 'stsewd/fzf-checkout.vim'

  use 'tami5/sql.nvim'

  -- fun
  use 'ThePrimeagen/vim-be-good'
end)

-- color stuff
-- require('terminal').setup()

