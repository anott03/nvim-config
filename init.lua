-- plugins
require 'plugins'
-- basic config
require 'settings'
require 'telescope-settings'
-- colorscheme
require'colorbuddy'.colorscheme'colorscheme/custom'
-- require'colorbuddy'.colorscheme'gruvbuddy'
-- lsp
require('lsp-settings').set_languages()
-- keybindings
require 'keybindings'
-- statusline
require 'statusline'
-- augroups
require 'augroups'

-- vim.cmd(":call cyclist#activate_listchars('amitav')")
