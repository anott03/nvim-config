local vim = vim
local M = {}

local local_plugin = function(name)
  vim.cmd('set rtp+=$HOME/dev/nvim/' .. name)
end

M.setup = function()
  -- local plugins
  -- local_plugin('termight.nvim')
  -- local_plugin('telescope.nvim')
  -- local_plugin('plenary.nvim')
  -- local_plugin('lsp-status.nvim')
  -- local_plugin('harpoon')
  -- local_plugin('neovim-irc-ui')
  -- local_plugin('lspui.nvim/feat-popup-sizing')
  -- local_plugin('git-worktree.nvim')
  -- local_plugin('telescope-frecency.nvim')
  -- local_plugin('refactoring.nvim')

  require('packer').startup(function(use)
    local local_use = function(plugin)
     use(string.format("~/dev/nvim/%s", plugin))
    end
    -- local_use('LuaSnip')
    local_use('lspcontainers.nvim')

    use 'wbthomason/packer.nvim'

    -- nvim-cmp + engines
    use 'neovim/nvim-lspconfig'
    -- use 'hrsh7th/nvim-cmp'
    -- use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-nvim-lua'
    -- use 'hrsh7th/cmp-nvim-lsp'
    -- use 'onsails/lspkind-nvim'

    -- other lsp and stuff
    use 'tjdevries/lsp_extensions.nvim'
    -- use {'glepnir/lspsaga.nvim', branch = 'main'}
    -- use 'mattn/emmet-vim'
    use 'rust-lang/rust.vim'
    -- use 'lervag/vimtex'


    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    -- colorscheme/aesthetic
    -- use 'gruvbox-community/gruvbox'
    use 'luisiacc/gruvbox-baby'
    -- use 'folke/tokyonight.nvim'
    use 'tjdevries/colorbuddy.vim'
    use 'hoob3rt/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- utilities
    use 'preservim/nerdcommenter'
    -- use 'mbbill/undotree'
    -- use 'nvim-treesitter/nvim-treesitter'
    -- use 'nvim-treesitter/playground'
    use 'norcalli/nvim-terminal.lua'
    -- use 'mhinz/vim-startify'
    -- use 'vimwiki/vimwiki'
    -- use 'tami5/sql.nvim'
    use 'tpope/vim-fugitive'
    -- use 'nanotee/luv-vimdocs'
    -- use 'rcarriga/nvim-notify'

    -- use 'kyazdani42/nvim-tree.lua'
  end)
end

M.initialize_plugins = function()
  -- require('a.plugins.git-worktree').setup()
  -- require('a.plugins.compe').setup()
  -- require('a.plugins.cmp').setup()
  require('a.plugins.telescope').setup()
  -- require('a.plugins.luasnip').setup()
  -- require('a.plugins.refactoring').setup()
  require('terminal').setup()
  -- require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
  -- require'nvim-treesitter.configs'.setup {
    -- ensure_installed = "all"
  -- }
  -- require('harpoon').setup({
  --   menu = {
  --     set_quick_menu_keymaps = function(bufnr)
  --       vim.api.nvim_buf_set_keymap(bufnr, 'n', '<esc>', '<cmd>q!<cr>', { noremap = true })
  --     end
  --   }
  -- })
  require('nvim-tree').setup({ disable_netrw = false })

  RELOAD = require('plenary.reload').reload_module
end

-- M.setup()
return M
