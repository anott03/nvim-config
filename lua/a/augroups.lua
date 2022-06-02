local vim = vim
local M = {}

-- TOOD: rewrite this ith native lua autocmds
M.setup = function()
  -- highlight yank
  vim.cmd("augroup highlight_yank")
  vim.cmd("autocmd!")
  vim.cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()")
  vim.cmd("augroup END")
end

-- set statusline
-- vim.cmd('augroup StatusLine')
-- vim.cmd('autocmd!')
-- vim.cmd('autocmd WinEnter,BufEnter * setlocal statusline=%!v:' .. require('a.statusline').active())
-- vim.cmd('autocmd WinLeave,BufLeave * setlocal statusline=%!v:' .. require('a.statusline').inactive())
-- vim.cmd('augroup END')

return M
