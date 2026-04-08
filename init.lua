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

-- leader key is space
vim.g.mapleader = ' '

-- require('a.plugins')
require('lazy').setup({
    import = "a.plugins"
}, {
    dev = { path = "~/dev" }
})
require("gitsigns").setup()
RELOAD = require('plenary.reload').reload_module

require('a.settings')
require('a.utils')
require('a.keybindings')
require('a.autocmds')
require('a.highlights');

-- TOGGLE_TRANSPARENCY()
