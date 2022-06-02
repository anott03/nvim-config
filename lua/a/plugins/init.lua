local vim = vim
local M = {}

local local_plugin = function(name)
  vim.cmd('set rtp+=$HOME/dev/nvim/' .. name)
end

M.setup = function()
  require('packer').startup(function(use)
    local local_use = function(plugin)
     use(string.format("~/dev/nvim/%s", plugin))
    end

    use 'wbthomason/packer.nvim'

    local_use('lspcontainers.nvim')
    use 'nvim-lua/plenary.nvim'
    use 'ms-jpq/coq_nvim'
    use 'neovim/nvim-lspconfig'
    use 'tjdevries/lsp_extensions.nvim'
    use 'rust-lang/rust.vim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-treesitter/nvim-treesitter'
    use 'luisiacc/gruvbox-baby'
    use 'hoob3rt/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'preservim/nerdcommenter'
    use 'norcalli/nvim-terminal.lua'
    use 'tpope/vim-fugitive'
    use 'anott03/termight.nvim'
  end)
end

M.initialize_plugins = function()
  require('a.plugins.telescope').setup()
  require('nvim-treesitter.configs').setup({
    highlight = {
      enable = true,
    },
    ensure_installed = "all"
  })
  RELOAD = require('plenary.reload').reload_module
end

M.setup()
return M
