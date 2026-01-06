if vim.g.vscode then
    return
end

local api = vim.api
local fn = vim.fn
local lsp = vim.lsp

require('a.plugins.cmp').setup()

local nnoremap = function(lhs, rhs, opts)
    vim.keymap.set('n', lhs, rhs, opts or { noremap = true })
end

local lsp_hover = function ()
    vim.lsp.buf.hover({ border="single" })
end

local lsp_diagnostics = function ()
    vim.diagnostic.open_float({ border="single" })
end

-- unmap K so that my custom mapping can take effect
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        -- Unmap K
        pcall(function () vim.keymap.del('n', 'K', { buffer = args.buf }) end)
    end,
})

local on_attach = function()
    nnoremap("gd", vim.lsp.buf.definition)
    nnoremap("gi", vim.lsp.buf.implementation)
    nnoremap("K", lsp_hover, { noremap=false, silent=true })
    nnoremap("<leader>K", lsp_diagnostics)
    nnoremap("<leader>w", vim.diagnostic.setloclist)
    nnoremap("<leader>rr", LSP_RENAME)

    -- trouble.nvim
    vim.keymap.set("n", "gr", function() require("trouble").toggle("lsp_references") end)

    vim.diagnostic.config({
        signs = true,
        virtual_text = true,
    })

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

vim.lsp.config("*", { on_attach = on_attach })

-- typescript {{{
vim.lsp.enable("ts_ls")
-- }}}
-- tailwind {{{
vim.lsp.enable("tailwindcss")
-- }}}
-- svelte {{{
vim.lsp.enable("svelte")
-- }}}
-- astro {{{
vim.lsp.enable("astro")
-- }}}

-- clang {{{
vim.lsp.config("clangd", {
    cmd={
        "clangd",
        "--background-index",
        "--log=verbose"
    },
    on_attach = on_attach
})
vim.lsp.enable("clangd")
-- }}}
-- rust {{{
vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = { },
    -- LSP configuration
    server = {
        on_attach = on_attach
    },
}
-- }}}
-- zig {{{
vim.lsp.enable("zls")
-- }}}
-- arduino {{{
-- vim.lsp.config("arduino_language_server", {
--     root_markers = { ".git", vim.fn.getcwd() },
-- })
-- vim.lsp.enable("arduino_language_server")
-- }}}
-- golang {{{
vim.lsp.config("gopls", {
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
vim.lsp.enable("gopls")
-- vim.cmd([[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)]])
-- }}}
-- gleam {{{
vim.lsp.enable("gleam")
-- }}}

-- ocaml {{{
vim.lsp.config("ocamllsp", {
    cmd={"/Users/amitavnott/.opam/default/bin/ocamllsp"},
    on_attach = on_attach
})
vim.lsp.enable("ocamllsp")

vim.lsp.config("millet", {
    cmd={"millet-ls"},
    filetypes={"sml", "cm", "mlb" },
    root_markers = { ".git", vim.fn.getcwd() },
})
vim.lsp.enable("millet")
-- }}}
-- elixir {{{
vim.lsp.config("elixirls", {
    cmd = {"elixir-ls"},
    on_attach=on_attach
});
vim.lsp.enable("elixirls")
-- }}}
-- erlang {{{
vim.lsp.enable("erlangls")
-- }}}
-- haskell {{{
vim.lsp.config("hls", {
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    on_attach = on_attach
})
vim.lsp.enable("hls")
-- }}}

-- vhdl {{{
vim.lsp.enable("vhdl_ls")
-- }}}

-- python {{{
vim.lsp.enable("pylsp")
-- }}}
-- lua {{{
vim.lsp.config("lua_ls", {
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
vim.lsp.enable("lua_ls")
-- }}}

-- latex {{{
vim.lsp.enable("ltex")
-- }}}
-- typst {{{
vim.lsp.enable("tinymist")
-- }}}

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

    api.nvim_set_option_value(
        "winhl",
        "Normal:HarpoonBorder",
        { win = win.border.win_id }
    )

    api.nvim_set_option_value('buftype', 'prompt', { buf = bufnr })
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
