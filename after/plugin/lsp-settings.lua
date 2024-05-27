local api = vim.api
local fn = vim.fn
local lsp = vim.lsp

-- NOTE THIS MUST HAPPEN BEFORE SETTING UP LSPCONFIG
require("neodev").setup({})

local lspconfig = require "lspconfig"
local lspcontainers = require 'lspcontainers'
require('a.plugins.cmp').setup()

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local nnoremap = function(lhs, rhs, opts)
    vim.keymap.set('n', lhs, rhs, opts or { noremap = true })
end

local vnoremap = function(lhs, rhs, opts)
    vim.keymap.set('v', lhs, rhs, opts or { noremap = true })
end

local on_attach = function()
    nnoremap("gd", vim.lsp.buf.definition)
    nnoremap("gi", vim.lsp.buf.implementation)
    -- nnoremap("gr", vim.lsp.buf.references)
    nnoremap("K", vim.lsp.buf.hover)
    -- vnoremap("K", vim.lsp.buf.hover)
    nnoremap("<leader>K", vim.diagnostic.open_float)
    nnoremap("<leader>w", vim.diagnostic.setloclist)
    nnoremap("<leader>rr", LSP_RENAME)
    nnoremap("<leader>a", LSP_CODE_ACTIONS)

    -- trouble.nvim
    vim.keymap.set("n", "gr", function() require("trouble").toggle("lsp_references") end)
end

lspconfig.zls.setup({
    on_attach = on_attach
})
lspconfig.vhdl_ls.setup({})
lspconfig.tsserver.setup({
    before_init = function(params)
        params.processId = vim.NIL
    end,
    on_attach = on_attach,
    -- cmd = require 'lspcontainers'.command('tsserver'),
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
})
lspconfig.astro.setup({
    on_attach = on_attach
})
require 'lspconfig'.svelte.setup({
    on_attach = on_attach,
})
lspconfig.svelte.setup({
    on_attach = on_attach
})
lspconfig.pylsp.setup({
    cmd = require 'lspcontainers'.command('pylsp'),
    on_attach = on_attach
})
lspconfig.clangd.setup({
    -- cmd = lspcontainers.command('clangd'),
    on_attach = on_attach
})
lspconfig.gopls.setup({
    cmd = lspcontainers.command('gopls'),
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        completUnimported = true,
        analyses = {
            unusedparams = true,
        }
    }
})
lspconfig.ocamllsp.setup({
    on_attach = on_attach
})
require'lspconfig'.millet.setup{
    cmd={"millet-ls"},
    filetypes={"sml", "cm", "mlb" },
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
}

-- lspconfig.rust_analyzer.setup({
-- -- cmd = lspcontainers.command('rust_analyzer'),
-- on_attach = on_attach
-- })

local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = on_attach,
        cmd = { "rustup", "run", "nightly", "rust-analyzer" }
    }
})
function Rust_inlay_hints()
    rt.inlay_hints.enable()
end

vim.cmd("autocmd BufEnter,BufWinEnter,TabEnter *.rs lua Rust_inlay_hints()")

lspconfig.lua_ls.setup({
    -- cmd = lspcontainers.command('sumneko_lua'),
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
                globals = {
                    'vim',
                    'describe',
                    'it'
                },
            },
        }
    }
})
require 'lspconfig'.svelte.setup {
    before_init = function(params)
        params.processId = vim.NIL
    end,
    on_attach = on_attach,
    cmd = lspcontainers.command('svelte'),
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
}

lspconfig.ltex.setup({ on_attach = on_attach })
lspconfig.texlab.setup({ on_attach = on_attach })

-- haskell
lspconfig.hls.setup({
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    on_attach = on_attach
})

-- golang
lspconfig.gopls.setup({
    cmd = { "gopls", "serve" },
    on_attach = on_attach,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
})

-- gleam
require'lspconfig'.gleam.setup({
    on_attach = on_attach
})

-- vim.cmd([[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)]])
vim.cmd([[set completeopt=menuone,noinsert,noselect]])

local function lsp_rename()
    local current_word = fn.expand("<cword>")

    local popup = require('popup')
    local bufnr = api.nvim_create_buf(false, false)

    local width = 60
    local height = 10
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    local _, win = popup.create(bufnr, {
        title = "Rename Token",
        highlight = "Normal",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
    })

    api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:HarpoonBorder"
    )

    api.nvim_buf_set_option(bufnr, 'buftype', 'prompt')
    api.nvim_buf_set_keymap(bufnr, 'i', '<esc>', '<cmd>q!<cr><esc>', { noremap = true })
    api.nvim_buf_set_keymap(bufnr, 'n', '<esc>', '<cmd>q!<cr><esc>', { noremap = true })

    vim.cmd [[ :startinsert ]]

    fn.prompt_setprompt(bufnr, string.format('rename %s to > ', current_word))
    fn.prompt_setcallback(bufnr, function(new_name)
        vim.cmd([[ q! ]])
        vim.schedule(function()
            lsp.buf.rename(new_name)
        end)
    end)
end

local lsp_code_actions = function()
    vim.lsp.buf.code_action()
end

LSP_RENAME = lsp_rename
LSP_CODE_ACTIONS = lsp_code_actions
