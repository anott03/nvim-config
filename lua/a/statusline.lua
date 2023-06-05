local vim = vim
local path = require('plenary.path')
local lspstatus = require('lsp-status')

lspstatus.config({ indicator_errors = '✗', indicator_warnings = '',
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

-- My Colorscheme
-- local highlights = {
--   {'Statusline',   { fg = '#3C3836', bg = '#89AAFF' }},
--   {'StatuslineNC', { fg = '#d0d0d0', bg = '#5c6370' }},
--   {'Mode',         { fg = '#d0d0d0', bg = '#5c6370', gui="bold" }},
--   {'Git',          { fg = '#EBDBB2', bg = '#3e4b59' }},
-- }

-- Gruvbox
local highlights = {
  {'AStatusline', { bg = '#3C3836', fg = '#EBDBB2' }},
  {'AStatuslineNC', { fg = '#3C3836', bg = '#928374' }},
  {'AStatuslineMode', { bg = '#928374', fg = '#1D2021', gui="bold" }},
  -- {'AStatuslineMode', { bg = '#B16286', fg = '#1D2021', gui="bold" }},
  {'AStatuslineGit', { bg = '#504945', fg = '#EBDBB2' }},
}


for _, highlight in ipairs(highlights) do
  set_hl(highlight[1], highlight[2])
end

Statusline.colors = {
  active        = '%#AStatusline#',
  inactive      = '%#AStatuslineNC#',
  mode          = '%#AStatuslineMode#',
  git           = '%#AStatuslineGit#',
}

Statusline.get_current_mode = function(self)
 local modes = {
    ['n']  = 'Normal';
    ['v']  = 'Visual';
    ['V']  = 'V·Line';
    [''] = 'V·Block';
    ['i']  = 'Insert';
    ['ic']  = 'Insert';
    ['R']  = 'Replace';
    ['c']  = 'Cmmand';
    ['t']  = 'Terminal';
  }
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(' %s ', modes[current_mode]):upper()
end

Statusline.get_git_status = function(self)
  if vim.api.nvim_eval('FugitiveHead()') ~= '' then
    return string.format('%s ', '  ' .. vim.api.nvim_eval('FugitiveHead()')) -- 
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
    self.colors.mode, mode, self.colors.active, filename, '%=',
    lspstatus.status(),
    '| ', '%p%% |', self.colors.git, git, self.colors.active
  })
end

Statusline.set_inactive = function()
  return '%= %t %r %='
end

Statusline.active   = function() return Statusline:set_active() end
Statusline.inactive = function() return Statusline:set_inactive() end

Statusline._simple_active = function(self)
  local git = self:get_git_status()
  local mode = self:get_current_mode()

  return table.concat({
    Statusline.colors.inactive,
    mode, '%= %t %r | ',
    git, '%='
  })
end

Statusline._simple_inactive = function()
  return Statusline.colors.inactive .. '%= %t %r %='
end

Statusline.simple_active   = function() return Statusline:_simple_active() end
Statusline.simple_inactive = function() return Statusline:_simple_inactive() end

-- set statusline
vim.cmd [[
  augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]]

-- vim.cmd [[
  -- augroup Statusline
    -- au!
    -- au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.simple_active()
    -- au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.simple_inactive()
  -- augroup END
-- ]]

-- require('lualine').setup({
  -- options = {
    -- theme = 'gruvbox',
    -- section_separators = '',
    -- component_separators = '',
  -- },
  -- sections = {
    -- lualine_a = { 'mode' },
    -- lualine_b = { 'branch' },
    -- lualine_c = { function() return Statusline:get_filename() end },
    -- lualine_x = { function() return require('lsp-status').status() end },
    -- -- lualine_x = {nil},
    -- lualine_y = { 'filetype' },
    -- lualine_z = { '' },
  -- }
-- })
