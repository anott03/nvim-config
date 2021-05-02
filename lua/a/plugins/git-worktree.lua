local Worktree = require('git-worktree')
local M = {}

M.setup = function()
  Worktree.setup({
    update_on_change = true,
    clearjumps_on_change = true,
    autopush = false,
  })
end

M.create_worktree = function()
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
