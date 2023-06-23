require('lazy').setup({
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
    'numToStr/Comment.nvim',
    'theprimeagen/harpoon',
    'ziglang/zig.vim',

    'simrat39/rust-tools.nvim',
    'rust-lang/rust.vim',

    'jose-elias-alvarez/null-ls.nvim',
    'MunifTanjim/eslint.nvim',
    'MunifTanjim/prettier.nvim',

    {
        'olexsmir/gopher.nvim',
        build = function()
            vim.cmd [[silent! GoInstallDeps]]
        end,
        config = function()
            require("gopher").setup()
        end
    },

    'lervag/vimtex',

    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    'kyazdani42/nvim-web-devicons',
    'norcalli/nvim-terminal.lua',
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',
    'anott03/termight.nvim',

    -- 'hoob3rt/lualine.nvim',
    'gruvbox-community/gruvbox',
    'luisiacc/gruvbox-baby',
    'tjdevries/colorbuddy.nvim',
    { "catppuccin/nvim",                          name = "catppuccin" },

    -- {dir = '/home/amitav/dev/nvim/sftp-sync.nvim'}
    'theprimeagen/vim-be-good',
    'tjdevries/sponge-bob.nvim',
})

-- require('a.plugins.telescope').setup()
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
    ensure_installed = "all"
})
require("gitsigns").setup()

RELOAD = require('plenary.reload').reload_module
