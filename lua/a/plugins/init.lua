require('lazy').setup({
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
    -- 'L3MON4D3/LuaSnip',
    'numToStr/Comment.nvim',
    'theprimeagen/harpoon',
    {
        'ziglang/zig.vim',
        config = function()
            vim.cmd [[let g:zig_fmt_autosave = 0]]
        end
    },
    'simrat39/rust-tools.nvim',
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
         "folke/trouble.nvim",
         dependencies = { "nvim-tree/nvim-web-devicons" },
         opts = require("a.plugins.trouble")
    },
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
    { "rose-pine/neovim", name = "rose-pine" },
    'RRethy/base16-nvim',

    'theprimeagen/vim-be-good',
    'tjdevries/sponge-bob.nvim',

    -- 'normen/vim-pio',
    -- 'coddingtonbear/neomake-platformio',
    {
        'anurag3301/nvim-platformio.lua',

        -- optional: cond used to enable/disable platformio
        -- based on existance of platformio.ini file and .pio folder in cwd.
        -- You can enable platformio plugin, using :Pioinit command
        cond = function()
            -- local platformioRootDir = vim.fs.root(vim.fn.getcwd(), { 'platformio.ini' }) -- cwd and parents
            local platformioRootDir = (vim.fn.filereadable('platformio.ini') == 1) and vim.fn.getcwd() or nil
            if platformioRootDir then
                -- if platformio.ini file exist in cwd, enable plugin to install plugin (if not istalled) and load it.
                vim.g.platformioRootDir = platformioRootDir
            elseif (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
                -- if nvim-platformio not installed, enable plugin to install it first time
                vim.g.platformioRootDir = vim.fn.getcwd()
            else                                             -- if nvim-platformio.lua installed but disabled, create Pioinit command
                vim.api.nvim_create_user_command('Pioinit',
                    function()                               --available only if no platformio.ini and .pio in cwd
                        vim.api.nvim_create_autocmd('User', {
                            pattern = { 'LazyRestore', 'LazyLoad' },
                            once = true,
                            callback = function(args)
                                if args.match == 'LazyRestore' then
                                    require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
                                elseif args.match == 'LazyLoad' then
                                    local pio_install_status = require('platformio.utils').pio_install_check()
                                    if not pio_install_status then return end
                                    vim.notify('PlatformIO loaded', vim.log.levels.INFO, { title = 'PlatformIO' })
                                    require("platformio").setup(vim.g.pioConfig)
                                    vim.cmd('Pioinit')
                                end
                            end,
                        })
                        vim.g.platformioRootDir = vim.fn.getcwd()
                        require('lazy').restore({ plguins = { 'nvim-platformio.lua' }, show = false })
                    end, {})
            end
            return vim.g.platformioRootDir ~= nil
        end,

        -- Dependencies are lazy-loaded by default unless specified otherwise.
        dependencies = {
            { 'akinsho/toggleterm.nvim' },
            { 'nvim-telescope/telescope.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'folke/which-key.nvim' },
            { 'nvim-treesitter/nvim-treesitter' }
        },
    }
}, {
    dev = {
        path = "~/dev"
    }
})

-- require('nvim-treesitter.configs').setup({
--     highlight = {
--         enable = true,
--     },
--     ensure_installed = "all"
-- })
require("gitsigns").setup()
require("a.plugins.mason")

RELOAD = require('plenary.reload').reload_module
