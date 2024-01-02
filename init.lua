-- bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("installing lazy.nvim")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

REMAP = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or {noremap = true})
end

require('a.plugins')
require('a.settings')
require('a.utils')
require('a.keybindings')
require('a.autocmds')
require('a.statusline')
require('a.highlights');
