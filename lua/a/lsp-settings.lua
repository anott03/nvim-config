local vim = vim
local lspconfig = require "lspconfig"

local set_languages = function()
  lspconfig.sumneko_lua.setup {                                             -- lua
    cmd = { "/home/amitav/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
        "-E", "/home/amitav/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
    };
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
  function rust_inlay_hints()
    require'lsp_extensions'.inlay_hints{
      highlight = "Comment",
      prefix = " >> ",
      aligned = true, only_current_line = false, enabled = { "ChainingHint" }
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
    -- on_attach=require'completion'.on_attach
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

local function lsp_rename()
  -- local current_word = vim.fn.expand("<cword>")
  local new_name = vim.fn.input("Enter new name: ")
  vim.lsp.buf.rename(new_name)
  -- local rename_window = require('plenary.window.float').percentage_range_window(0.5, 0.2)
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
  lsp_rename = lsp_rename,
  lsp_code_actions = lsp_code_actions
}
