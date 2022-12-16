local ls = require'luasnip'
-- local s = ls.s
-- local sn = ls.sn
-- local t = ls.t
-- local i = ls.i
-- local f = ls.f
-- local c = ls.c
-- local d = ls.d

local M = {}
vim.g.snippets = "luasnip"

-- local function char_count_same(c1, c2)
  -- local line = vim.api.nvim_get_current_line()
  -- local _, ct1 = string.gsub(line, c1, "")
  -- local _, ct2 = string.gsub(line, c2, "")
  -- return ct1 == ct2
-- end

-- local function neg(fn, ...)
  -- return not fn(...)
-- end

-- local all =  {
  -- s({ trig = "(" }, { t { "(" }, i(1), t { ")" }, i(0) }),
  -- s({ trig = "{" }, { t { "{" }, i(1), t { "}" }, i(0) }),
  -- s({ trig = "[" }, { t { "[" }, i(1), t { "]" }, i(0) }),
-- }

-- local lua =  {
  -- s({ trig = "func", dscr = "function" }, {
    -- t {"local function "}, i(1, {"name"}), t({"("}), i(2, {"..."}), t({")", ""}), i(0), t({"", "end"})
  -- }),

  -- s({ trig = "M.", dscr = "function" }, {
    -- t {"M."}, i(1, {"name"}), t({" = function("}), i(2, {"..."}), t({")"}), i(0), t({"", "end"})
  -- }),
-- }

-- local golang = {
  -- s({ trig = "ferr" }, {
    -- i(1, {'val'}), t({', '}), i(2, {'err'}), t({' := '}), i(3, {'f'}), t({'()'}), i(0)
  -- }),
  -- s({ trig = "func" }, {
    -- t({"func "}), i(1, {"name"}), t({"("}), i(2, {"params"}), t({") "}), i(3, {"returns"}), t({" {", "", "}"}), i(0)
  -- })
-- }

M.setup = function()
  -- ls.snippets = {
    -- all = all,
    -- lua = lua,
    -- go = golang,
  -- }

  vim.cmd [[
    imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
    imap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'
    snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<cr>
    snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<cr>
  ]]
end

M.setup()
