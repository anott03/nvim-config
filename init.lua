-- plugins
require 'a.plugins'
-- basic config
require('a.settings').setup()
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
