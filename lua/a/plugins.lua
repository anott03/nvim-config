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
local_plugin('lspui.nvim/feat-popup-sizing')
local_plugin('git-worktree.nvim')

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- nvim-lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
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

  -- git
  use 'tpope/vim-fugitive'

  -- fun
  use 'ThePrimeagen/vim-be-good'
end)

-- initializing plugins
require('terminal').setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained"
}

-- completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

-- git worktree
require('git-worktree').setup({
  update_on_change = true,
  clearjumps_on_change = true,
  autopush = false,
})
require('telescope').load_extension('git_worktree')
