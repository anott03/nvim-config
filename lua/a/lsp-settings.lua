local vim = vim
local lspconfig = require "lspconfig" local lspcontainers = require 'lspcontainers'

local set_languages = function() lspconfig.hls.setup({})
  lspconfig.tsserver.setup({
    -- cmd = lspcontainers.command('tsserver')
  })
  lspconfig.bashls.setup({})
  lspconfig.html.setup({})
  -- lspconfig.pyls.setup({})
  lspconfig.clangd.setup({})
  lspconfig.svelte.setup({})
  lspconfig.perlls.setup({})
  lspconfig.gopls.setup({
    cmd = lspcontainers.command('gopls')
  })
  lspconfig.rust_analyzer.setup({
    cmd = lspcontainers.command('rust_analyzer')
  })

  lspconfig.sumneko_lua.setup({
    cmd = lspcontainers.command('sumneko_lua'),
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
  })

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
  local current_word = vim.fn.expand("<cword>")
  -- local new_name = vim.fn.input(string.format("Rename `%s` to > ", current_word))
  -- vim.lsp.buf.rename(new_name)


  local popup = require('popup')
  local bufnr = vim.api.nvim_create_buf(false, false)

  local width = 60
  local height = 10
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

  local win_id, win = popup.create(bufnr, {
      title = "Rename Token",
      highlight = "Normal",
      line = math.floor(((vim.o.lines - height) / 2) - 1),
      col = math.floor((vim.o.columns - width) / 2),
      minwidth = width,
      minheight = height,
      borderchars = borderchars,
  })

  vim.api.nvim_win_set_option(
      win.border.win_id,
      "winhl",
      "Normal:HarpoonBorder"
  )

  vim.api.nvim_buf_set_option(bufnr, 'buftype', 'prompt')
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<esc>', '<cmd>q!<cr><esc>', {noremap=true})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<esc>', '<cmd>q!<cr><esc>', {noremap=true})

  vim.cmd [[ :startinsert ]]

  vim.fn.prompt_setprompt(bufnr, string.format('rename %s to > ', current_word))
  vim.fn.prompt_setcallback(bufnr, function(new_name)
    vim.cmd([[ q! ]])
    vim.schedule(function()
      vim.lsp.buf.rename(new_name)
    end)
  end)
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
