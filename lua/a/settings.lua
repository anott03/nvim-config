local vim = vim

local cmd = vim.api.nvim_command
local apply_options = function(opts)
  for k, v in pairs(opts) do
    vim.o[k] = v
  end
end

local settings = {
  errorbells = false,
  number = true,
  relativenumber = true,
  smartindent = true,
  mouse = 'a',
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  swapfile = false,
  showmode = false,
  wrap = false,
  signcolumn = 'yes',
  undofile = true,
  undodir = '~/.local/share/nvim/undodir',
  listchars='eol:<',
  splitbelow = true,
  splitright = true,
  cursorline = true,
  termguicolors = true,
  background = 'dark',
  colorcolumn = '80',
  exrc = true,
  hidden = true,
}

apply_options(settings)

vim.g.NERDSpaceDelims = 1
vim.g.UltiSnipsExpandTrigger = "<C-l>"
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0 vim.g.netrw_browse_split = 0 vim.g.netrw_winsize = 12
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection='0'

vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

vim.cmd[[ let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}] ]]
vim.cmd[[set guifont=FiraCode\ Nerd\ Font:h12]]

-- require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

-- golang stuff
vim.cmd([[
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
]])

-- vim.api.nvim_exec([[
-- :call cyclist#add_listchar_option_set('amitav', {'eol': '↲'})
-- :call cyclist#activate_listchars('amitav')
-- ]], {})

-- telescope
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
