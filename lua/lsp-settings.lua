local vim = vim
local lspconfig = require "lspconfig"

local set_languages = function()
  lspconfig.tsserver.setup{ on_attach=require'completion'.on_attach }       -- typescript
  lspconfig.bashls.setup{ on_attach=require'completion'.on_attach }         -- bash
  -- lspconfig.vimls.setup{on_attach=require'completion'.on_attach}            -- vim script
  lspconfig.html.setup{on_attach=require'completion'.on_attach}             -- html
  lspconfig.pyls.setup{on_attach=require'completion'.on_attach}             -- python
  lspconfig.clangd.setup{on_attach=require'completion'.on_attach}           -- c and c++
  lspconfig.svelte.setup{on_attach=require'completion'.on_attach}           -- c and c++
  lspconfig.perlls.setup{on_attach=require'completion'.on_attach}           -- c and c++
  lspconfig.sumneko_lua.setup {                                             -- lua
    cmd = { "/home/amitav/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
        "-E", "/home/amitav/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
    };
    on_attach=require'completion'.on_attach;
    settings = {
      Lua = {
        runtime = {version = 'LuaJIT'},
        diagnostics = {
          globals = {
            -- Get the language server to recognize the `vim` global
            'vim',
            -- testing stuff
            'describe',
            'it'
          },
        },
      }
    }
  }

  -- rust
  lspconfig.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
  function rust_inlay_hints()
    require'lsp_extensions'.inlay_hints{
      highlight = "Comment",
      prefix = " >> ",
      aligned = true,
      only_current_line = false,
      enabled = { "ChainingHint" }
    }
  end
  vim.cmd("autocmd BufEnter,BufWinEnter,TabEnter *.rs lua rust_inlay_hints()")

  -- golang
  lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
    on_attach=require'completion'.on_attach
  }

  function goimports(timeoutms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local method = "textDocument/codeAction"
    local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
    if resp and resp[1] then
      local result = resp[1].result
      if result and result[1] then
        local edit = result[1].edit
        vim.lsp.util.apply_workspace_edit(edit)
      end
    end

    vim.lsp.buf.formatting()
  end

  vim.cmd([[autocmd BufWritePre *.go lua goimports(1000)]])
  vim.cmd([[set completeopt=menuone,noinsert,noselect]])
end

-- currently not being used since I'm using lspsaga
local function lspRename()
  local current_word = vim.fn.expand("<cword>")
  local plenary_window = require('plenary.window.float').percentage_range_window(0.5, 0.2)
  vim.api.nvim_buf_set_option(plenary_window.bufnr, 'buftype', 'prompt')
  vim.fn.prompt_setprompt(plenary_window.bufnr, string.format('Rename "%s" to > ', current_word))
  vim.api.nvim_buf_set_keymap(plenary_window.bufnr, 'n', '<ESC>', '<CMD>q!<CR>', {})
  vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
    vim.api.nvim_win_close(plenary_window.win_id, true)

    if text ~= '' then
      vim.schedule(function()
        vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })
        vim.lsp.buf.rename(string.sub(text, 2))
      end)
    else
      print("Nothing to rename!")
      vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })
    end
  end)

  vim.cmd [[startinsert]]
end

local lsp_code_actions = function()
  local opts = require('telescope.themes').get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').lsp_code_actions(opts)
end

return {
  set_languages = set_languages,
  lspRename = lspRename,
  lsp_code_actions = lsp_code_actions
}
