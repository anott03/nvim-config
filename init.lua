require('a.plugins').setup()
require('a.plugins').initialize_plugins()
require('a.settings').setup()
require('a.telescope-settings').setup()
require('a.lsp-settings').set_languages()
require 'a.keybindings'
require 'a.statusline'
require 'a.augroups'

vim.cmd [[ colorscheme gruvbox ]]
