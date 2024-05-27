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
    {
         "folke/trouble.nvim",
         dependencies = { "nvim-tree/nvim-web-devicons" },
         opts = require("a.plugins.trouble")
     },
     { "folke/neodev.nvim", opts = {} },
     {
       'stevearc/oil.nvim',
       opts = {},
       dependencies = { "nvim-tree/nvim-web-devicons" },
     },

    'MunifTanjim/eslint.nvim',
    'MunifTanjim/prettier.nvim',
    'gleam-lang/gleam.vim',

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },

    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",

    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    'kyazdani42/nvim-web-devicons',
    'norcalli/nvim-terminal.lua',
    'tpope/vim-fugitive',
    'theprimeagen/git-worktree.nvim',
    'lewis6991/gitsigns.nvim',
    'anott03/termight.nvim',

    'gruvbox-community/gruvbox',
    'luisiacc/gruvbox-baby',
    'tjdevries/colorbuddy.nvim',
    { "catppuccin/nvim", name = "catppuccin" },
    'RRethy/base16-nvim',

    'theprimeagen/vim-be-good',
    'tjdevries/sponge-bob.nvim',

    'coddingtonbear/neomake-platformio',

    {
        "anott03/vimnote",
        dev = true,
        config = function()
            require("vimnote").setup({
                pdf_reader = "zathura"
            })
        end
    },
}, {
    dev = {
        path = "~/dev"
    }
})

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
    ensure_installed = "all"
})
require("gitsigns").setup()
require("a.plugins.mason")

RELOAD = require('plenary.reload').reload_module
