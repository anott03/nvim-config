local vim = vim
local M = {}

local apply_options = function(opts, endpoint)
  for k, v in pairs(opts) do
    endpoint[k] = v
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
  undodir = vim.loop.os_homedir() .. '/.local/share/nvim/undodir',
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

local globals = {
  completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'},
  NERDSpaceDelims = 1,

  gruvbox_contrast_dark = 'hard',
  gruvbox_invert_selection='0',
  tokyonight_style = "night",

  netrw_liststyle = 3,
  netrw_banner = 0,
  netrw_browse_split = 0,
  netrw_winsize = 12,

  go_highlight_fields = 1,
  go_highlight_functions = 1,
  go_highlight_function_calls = 1,
  go_highlight_extra_types = 1,
  go_highlight_operators = 1,
}

M.setup = function()
  apply_options(settings, vim.o)
  apply_options(globals, vim.g)

  vim.cmd [[ colorscheme gruvbox ]]
  vim.cmd[[ let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}] ]]
  vim.cmd[[set guifont=FiraCode\ Nerd\ Font:h12]]

  require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
  vim.cmd("autocmd BufEnter,BufWinEnter,TabEnter * lua apply_buf_enter_settings()")
end

function apply_buf_enter_settings()
  local filetype = vim.bo.filetype

  if filetype ~= 'netrw' and filetype ~= 'startify' then
    vim.cmd [[ set nu rnu signcolumn=yes ]]
  end
end

return M
