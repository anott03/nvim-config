local Worktree = require('git-worktree')
local float = require('plenary.window.float')
local api = vim.api

local M = {}

M.create_worktree = function()
  -- local win_stats = float.percentage_range_window(0.2, 0.4)
  -- local bufnr = win_stats.burnr

  -- api.nvim_buf_set_keymap(bufnr, "n", "<esc>", "<cmd>q!<cr>", {})
  -- api.nvim_buf_set_option(bufnr, 'buftype','prompt')

  -- vim.fn.prompt_setprompt(bufnr, "Worktree name > ")
  -- vim.fn.prompt_setcallback(bufnr, function(worktree_name)
    -- -- Worktree.create_worktree(worktree_name, upstream)
  -- end)

  local worktree_name = vim.fn.input("Worktree name > ")
  local worktree_upstream = vim.fn.input("Worktree upstream > ")

  if string.gsub(worktree_name, " ", "") == '' or
    string.gsub(worktree_upstream, " ", "") == '' then
    return
  end

  Worktree.create_worktree(worktree_name, worktree_upstream)
end

M.switch_worktree = function()
  local worktree_name = vim.fn.input("Worktree to select > ")

  if string.gsub(worktree_name, " ", "") == '' then
    return
  end

  Worktree.switch_worktree(worktree_name)
end

M.delete_worktree = function()
  local worktree_name = vim.fn.input("Worktree to remove > ")

  if string.gsub(worktree_name, " ", "") == '' then
    return
  end

  Worktree.delete_worktree(worktree_name)
end

return M
