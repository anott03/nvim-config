local M = {}

local cmp = require "cmp"
local lspkind = require "lspkind"

M.setup = function()
  cmp.setup {
    mapping = {
      ["<Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,

      ["<S-Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end
    },

    sources = {
      -- ORDER MATTERS (it sets priority)
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
    },

    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
        }
      }
    },

    experimental = {
      native_menu = false,
      ghost_text = true,
    }
  }
end

return M
