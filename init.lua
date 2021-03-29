-- plugins
require 'plugins'
-- basic config
require 'settings'
require 'telescope-settings'
-- colorscheme
vim.cmd[[
  colorscheme colorscheme/custom
  hi Normal guibg=None
]]
-- lsp
require('lsp-settings').set_languages()
-- keybindings
require 'keybindings'
-- statusline
require 'statusline'
-- augroups
require 'augroups'
