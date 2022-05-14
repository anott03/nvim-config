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
  softtabstop = 2, expandtab = true, swapfile = false,
  showmode = true,
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
  -- laststatus = 3,
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

M.setup = function()
  vim.cmd [[ set laststatus=0 ]]
  apply_options(settings, vim.o)
  apply_options(globals, vim.g)

  -- vim.cmd [[
    -- colorscheme gruvbox-baby
    -- hi ModeMsg guifg=#c792ea
  -- ]]
  vim.cmd [[ colo gruvbox-baby ]]

  vim.cmd[[ let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}] ]]
  vim.cmd[[set guifont=FiraCode\ Nerd\ Font:h12]]

  -- vim.cmd("autocmd BufEnter,BufWinEnter,TabEnter * lua apply_buf_enter_settings()")
end

function apply_buf_enter_settings()
  local filetype = vim.bo.filetype
  if filetype ~= 'netrw' and filetype ~= 'startify'
	  and vim.bo.modifiable == true then
    vim.cmd [[ set nu rnu signcolumn=yes ]]
  end
end

-- TODO figure out a way to make neovim run lua files without requiring them to
-- be named that is more efficient than this.
function SO()
  if vim.bo.filetype ~= 'lua' then
    vim.cmd[[so]]
  else
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local snippet = ""
    for _, l in pairs(lines) do
      snippet = snippet .. l .. "\n"
    end
    vim.cmd("lua << EOF\n"..snippet.."\nEOF")
  end
end

return M
