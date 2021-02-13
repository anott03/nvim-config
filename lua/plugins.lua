local plugins = {
  -- language support
  {'sheerun/vim-polyglot', nil},
  {'neovimhaskell/haskell-vim', nil},
  -- {'fatih/vim-go', {['do'] = '\':GoUpdateBinaries\''}},
  {'neoclide/vim-jsx-improve', nil},
  {'anott03/vim-react-snippets', nil},
  {'mattn/emmet-vim', nil},
  {'rust-lang/rust.vim', nil},

  -- nvim-lsp
  {'neovim/nvim-lspconfig', nil},
  {'nvim-lua/completion-nvim', nil},
  {'tjdevries/lsp_extensions.nvim', nil},

  -- colorschemes
  {'gruvbox-community/gruvbox', nil},
  {'joshdick/onedark.vim', nil},
  {'tjdevries/colorbuddy.vim', nil},
  {'tjdevries/gruvbuddy.nvim', nil},
  -- { 'ntk148v/vim-horizon', nil},
  -- {'vim-airline/vim-airline', nil},
  -- {'vim-airline/vim-airline-themes', nil},

  -- utilities
  {'junegunn/fzf', {['do'] = '{ -> fzf#install() }'}},
  {'junegunn/fzf.vim', nil},
  {'preservim/nerdcommenter', nil},
  {'nvim-lua/popup.nvim', nil},
  {'neoclide/coc.nvim', {branch = '\'release\''}},
  {'mbbill/undotree', nil},
  {'kyazdani42/nvim-web-devicons', nil},
  {'nvim-treesitter/nvim-treesitter', nil},
  {'nvim-treesitter/playground'},
  {'norcalli/nvim-terminal.lua', nil},
  {'nvim-lua/lsp_extensions.nvim', nil},

  -- git
  {'tpope/vim-fugitive', nil},
  {'stsewd/fzf-checkout.vim', nil},

  {'nvim-telescope/telescope-frecency.nvim', nil},
  {'tami5/sql.nvim', nil},

  -- fun
  {'ThePrimeagen/vim-be-good', nil},
}

require('lua-vim-plug')(plugins)

-- local plugins
local vim = vim
local local_plugin = function(name) vim.cmd('set rtp+=$HOME/dev/nvim/' .. name) end
local_plugin('termight.nvim')
local_plugin('telescope.nvim')
local_plugin('plenary.nvim')
local_plugin('popup.nvim')
local_plugin('lsp-status.nvim')

-- telescope plugins
require('telescope').load_extension('frecency')
