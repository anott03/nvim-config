return {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        lazy=false,
        build=':TSUpdate'
    },

    'neovim/nvim-lspconfig',
    'nvim-lua/lsp-status.nvim',
    'onsails/lspkind-nvim',
    'numToStr/Comment.nvim',
    'theprimeagen/harpoon',
    {
        'ziglang/zig.vim',
        config = function()
            vim.cmd [[let g:zig_fmt_autosave = 0]]
        end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    'rust-lang/rust.vim',
    {
        'olexsmir/gopher.nvim',
        build = function()
            vim.cmd [[silent! GoInstallDeps]]
        end,
        config = function()
            require("gopher").setup({})
        end
    },
    'lervag/vimtex',
    {
        'chomosuke/typst-preview.nvim',
        lazy = false, -- or ft = 'typst'
        version = '1.*',
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

    {
      'stevearc/oil.nvim',
      opts = {},
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    'gleam-lang/gleam.vim',

    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",

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
    { "rose-pine/neovim", name = "rose-pine" },
    'RRethy/base16-nvim',

    'theprimeagen/vim-be-good',
    'tjdevries/sponge-bob.nvim',

    {
        "S1M0N38/love2d.nvim",
        event = "VeryLazy",
        version = "2.*",
        opts = {},
    }
}
