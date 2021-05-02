-- plugins
require 'a.plugins'
-- basic config
require 'a.settings'
require('a.telescope-settings').setup()
-- colorscheme
vim.cmd [[ colorscheme gruvbox ]]
-- lsp
require('a.lsp-settings').set_languages()
-- keybindings
require 'a.keybindings'
-- statusline
require 'a.statusline'
-- augroups
require 'a.augroups'

local path = require('plenary.path')
return {
  reload_config = function()
    require('plenary.reload').reload_module('init')
    require('init')
    print(path:new({vim.loop.os_homedir(), '.config/nvim/init.lua'}):absolute())
    vim.cmd('luafile' .. path:new({vim.loop.os_homedir(), '.config/nvim/init.lua'}):absolute())
  end
}
