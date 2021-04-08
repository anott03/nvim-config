local vim = vim
local path = require('plenary.path')
local lspstatus = require('lsp-status')

lspstatus.config({
  indicator_errors = '✗',
  indicator_warnings = '',
  indicator_hint = '',
  status_symbol = ''
})

Statusline = {}

local set_hl = function(group, options)
  local bg = options.bg == nil and '' or 'guibg=' .. options.bg
  local fg = options.fg == nil and '' or 'guifg=' .. options.fg
  local gui = options.gui == nil and '' or 'gui=' .. options.gui

  vim.cmd(string.format('hi %s %s %s %s', group, bg, fg, gui))
end

local highlights = {
  {'StatusLine',   { fg = '#3C3836', bg = '#89AAFF' }},
  {'StatusLineNC', { fg = '#d0d0d0', bg = '#5c6370' }},
  {'Mode',         { fg = '#d0d0d0', bg = '#5c6370', gui="bold" }},
  {'Git',          { fg = '#EBDBB2', bg = '#3e4b59' }},
}

for _, highlight in ipairs(highlights) do
  set_hl(highlight[1], highlight[2])
end

Statusline.colors = {
  active        = '%#StatusLine#',
  inactive      = '%#StatuslineNC#',
  mode          = '%#Mode#',
  mode_alt      = '%#ModeAlt#',
  git           = '%#Git#',
  git_alt       = '%#GitAlt#',
  filetype      = '%#Filetype#',
  filetype_alt  = '%#FiletypeAlt#',
  line_col      = '%#LineCol#',
  line_col_alt  = '%#LineColAlt#',
}

Statusline.get_current_mode = function(self)
 local modes = {
    ['n']  = 'Normal';
    ['v']  = 'Visual';
    ['V']  = 'V·Line';
    [''] = 'V·Block';
    ['i']  = 'Insert';
    ['R']  = 'Replace';
    ['c']  = 'Cmmand';
    ['t']  = 'Terminal';
  }
  local current_mode = vim.api.nvim_get_mode().mode
  return self.colors.mode .. string.format(' %s ', modes[current_mode]):upper() .. self.colors.active
end

Statusline.get_git_status = function(self)
  if vim.api.nvim_eval('FugitiveHead()') ~= '' then
    return self.colors.git .. string.format('%s ', '  ' .. vim.api.nvim_eval('FugitiveHead()')) .. self.colors.active -- 
  else
    return ' '
  end
end

Statusline.get_filename = function(self)
  local bufname = vim.api.nvim_buf_get_name(0)
  local icon = require'nvim-web-devicons'.get_icon(bufname, string.match(bufname, '%a+$'), {}) or ''
  if icon then icon = icon .. ' ' end
  local filename = vim.api.nvim_buf_get_name(0)
  if not string.find(filename, "^term") then
    filename = path.new((path.new(filename)):make_relative()):shorten()
  else
    filename = "bash"
  end
  if self:get_git_status() == ' ' or self:get_git_status() == nil then
    return ' ' .. icon .. filename .. " %r%{&modified?'[+]':''}"
  end
  return ' ' .. icon .. filename .. " %r%{&modified?'[+]':''}"
end

Statusline.get_filetype = function()
  local filetype = vim.bo.filetype
  filetype = string.format(' %s ', filetype):lower()
  return filetype
end

Statusline.set_active = function(self)
  local mode = self:get_current_mode()
  local git = self:get_git_status()
  local filename = self:get_filename()
  local filetype = self:get_filetype()

  return table.concat({
    mode, git, filename, '%=',
    lspstatus.status(), ' | ', '%p%%', filetype
  })
end

Statusline.set_inactive = function(self)
  return '%= %t %r %='
end

Statusline.active   = function() return Statusline:set_active() end
Statusline.inactive = function() return Statusline:set_inactive() end

-- set statusline
vim.cmd('augroup Statusline')
vim.cmd('au!')
vim.cmd('au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()')
vim.cmd('au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()')
vim.cmd('augroup END')