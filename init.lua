require('a.plugins').setup()
require('a.plugins').initialize_plugins()
require('a.settings').setup()
require('a.lsp-settings').set_languages()
require('a.keybindings').setup()
require('a.statusline').setup()
require('a.augroups').setup()

vim.cmd [[ colorscheme gruvbox ]]
