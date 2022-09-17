local vim = vim

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
  tabstop = 2, softtabstop = 2, expandtab = true, swapfile = false,
  showmode = false,
  wrap = false,
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
  signcolumn = 'no',
  winbar="%=%m %f"
}

local globals = {
  completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'},
  NERDSpaceDelims = 1,

  gruvbox_contrast_dark = 'hard',
  gruvbox_invert_selection='0',
  gruvbox_baby_function_style = "NONE",
  gruvbox_baby_keyword_style = "italic",
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

  haskell_enable_quantification = 1,
  haskell_enable_recursivedo = 1,
  haskell_enable_arrowsyntax = 1,
  haskell_enable_pattern_synonyms = 1,
  haskell_enable_typeroles = 1,
  haskell_enable_static_pointers = 1,
  haskell_backpack = 1
}

apply_options(settings, vim.o)
apply_options(globals, vim.g)

vim.cmd [[ set laststatus=3 ]]
vim.cmd [[ colo a/colorscheme ]]
-- vim.cmd [[
  -- hi Normal guibg=None
  -- hi LineNr guifg=#EEBD35
  -- hi CursorLineNr guifg=#EEBD35
  -- hi CursorLine guibg=#423f3b
  -- hi Visual guibg=#423f3b
-- ]]
vim.cmd[[set guifont=FiraCode\ Nerd\ Font:h12]]
