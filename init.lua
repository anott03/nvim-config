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

require('a.plugins')
require('a.settings')
require('a.utils')
require('a.keybindings')
require('a.autocmds')
require('a.statusline')

require("sftp-sync").setup({
  pattern = "*.lua",
  project_dir = "/home/amitav/dev/nvim/sftp-sync.nvim"
})
