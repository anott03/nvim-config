local vim = vim
local M = {}

local local_plugin = function(name)
  vim.cmd('set rtp+=$HOME/dev/nvim/' .. name)
end

M.setup = function()
  -- local plugins
  local_plugin('termight.nvim')
  local_plugin('telescope.nvim')
  local_plugin('plenary.nvim')
  local_plugin('popup.nvim')
  local_plugin('lsp-status.nvim')
  local_plugin('harpoon')
  local_plugin('neovim-irc-ui')
  local_plugin('lspui.nvim/feat-popup-sizing')
  local_plugin('git-worktree.nvim')
  local_plugin('telescope-frecency.nvim')
  -- local_plugin('lspcontainers.nvim')
  -- local_plugin('LuaSnip')

  require('packer').startup(function(use)
    local local_use = function(plugin)
        use(string.format("~/dev/nvim/%s", plugin))
    end
    local_use('LuaSnip')
    local_use('lspcontainers.nvim')

    use 'wbthomason/packer.nvim'

    -- nvim-lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'tjdevries/lsp_extensions.nvim'
    use {'glepnir/lspsaga.nvim', branch = 'main'}
    -- other language suff
    use 'mattn/emmet-vim'
    use 'rust-lang/rust.vim'
    use 'lervag/vimtex'

    -- colorscheme/aesthetic
    use 'gruvbox-community/gruvbox'
    use 'tjdevries/colorbuddy.vim'
    use 'hoob3rt/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- utilities
    use 'preservim/nerdcommenter'
    use 'mbbill/undotree'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'
    use 'norcalli/nvim-terminal.lua'
    use 'mhinz/vim-startify'
    use 'vimwiki/vimwiki'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'tami5/sql.nvim'
    use 'tpope/vim-fugitive'
    use "nanotee/luv-vimdocs"
  end)
end

M.initialize_plugins = function()
  require('a.plugins.git-worktree').setup()
  require('a.plugins.compe').setup()
  require('a.plugins.telescope').setup()
  require('a.plugins.luasnip').setup()
  require('terminal').setup()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained"
  }
  -- require('bufferline').setup({})
  require('harpoon').setup({
    -- menu = {
      -- set_quick_menu_keymaps = function(bufnr)
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<esc>', '<cmd>q!<cr>', { noremap = true })
      -- end
    -- }
  })
end

M.setup()
return M
