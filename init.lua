-- plugins
require 'a.plugins'
-- basic config
require 'a.settings'
require 'a.telescope-settings'
-- colorscheme
vim.cmd[[
  colorscheme a/colorscheme/custom
]]
-- lsp
require('a.lsp-settings').set_languages()
-- keybindings
require 'a.keybindings'
-- statusline
require 'a.statusline'
-- augroups
require 'a.augroups'

return {
  reload_config = function()
    print('reloading config')
    require('plenary.reload').reload_module('init')
    require('init')
  end
}
