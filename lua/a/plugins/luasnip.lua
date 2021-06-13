local ls = require'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

local M = {}
vim.g.snippets = "luasnip"

local function char_count_same(c1, c2)
  local line = vim.api.nvim_get_current_line()
  local _, ct1 = string.gsub(line, c1, "")
  local _, ct2 = string.gsub(line, c2, "")
  return ct1 == ct2
end

local function neg(fn, ...)
  return not fn(...)
end

M.setup = function()
  ls.snippets = {
    all = M.all(),
    lua = M.lua(),
    go = M.go(),
  }

  vim.cmd [[
    imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
    imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
    snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<cr>
    snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<cr>
  ]]
end

M.all = function()
  return {
    s({ trig = "(" }, { t { "(" }, i(1), t { ")" }, i(0) }, neg, char_count_same, "%(", "%)"),
    s({ trig = "{" }, { t { "{" }, i(1), t { "}" }, i(0) }, neg, char_count_same, "%{", "%}"),
  }
end

M.lua = function()
  return {
    s({ trig = "f", dscr = "function" }, {
      t { "function " }, i(1, {"name"}), t { "(" }, i(2, "..."), t { ")", "", "return", "end" }, i(0)
    }),
  }
end

M.go = function()
  return {
    s({ trig = "err" }, {
      i(1, {'val'}), t({', '}), i(2, {'err'}), t({' := '}), i(3, {'f'}), t({'()'}), i(0)
    }),
    s({ trig = "func" }, {
      t({"func "}), i(1, {"name"}), t({"("}), i(2, {"params"}), t({") "}), i(3, {"returns"}), t({"{", "", "}"}), i(0)
    })
  }
end

M.setup()
return M
