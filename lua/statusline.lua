local vim = vim
local fn = vim.fn
local path = require('plenary.path')
local lspstatus = require('lsp-status')
lspstatus.config({
  indicator_errors = '✗',
  indicator_warnings = '',
  indicator_hint = '',
})

StatusLine = {}

-- colors are defined in my custom colorscheme
StatusLine.colors = {
  active      = "%#StatusLineActive#",
  active_dark = "%#StatusLineActiveDark#",
  inactive    = "%#StatusLineInactive#",
  mode        = "%#StatusLineMode#",
  mode_arrow1 = "%#StatusLineModeArrow1#",
  mode_arrow2 = "%#StatusLineModeArrow2#",
  git_arrow   = "%#StatusLineGitArrow#",

  blue         = "%#SLBlue#",
  magenta      = "%#SLMagneta#",
  green        = "%#SLGreen#",
  yellow       = "%#SLYellow#",
  red          = "%#SLRed#",
}

StatusLine.powerline = false

StatusLine.separators = {
  arrow = { '', '' },
  rounded = { '', '' },
}

StatusLine.get_current_mode = function(self)
 local modes = {
    ['n']  = {'Normal', 'N'};
    ['v']  = {self.colors.yellow .. 'Visual',   'V' };
    ['V']  = {self.colors.yellow .. 'V·Line',   'V' };
    [''] = {self.colors.yellow .. 'V·Block',  'V'};
    ['i']  = {self.colors.blue   .. 'Insert',   'S'};
    ['R']  = {self.colors.red    .. 'Replace',  'R'};
    ['c']  = {self.colors.green  .. 'Cmmand',   'C'};
    ['t']  = {self.colors.green  .. 'Terminal', 'T'};
  }
  local current_mode = fn.mode()
  local modeArrow = self:get_mode_arrow()
  if self.powerline then
    return string.format(' %s ', modes[current_mode][1]):upper() .. modeArrow
  end
  return string.format(' %s', modes[current_mode][1]):upper()
end

StatusLine.get_mode_arrow = function(self)
  if vim.api.nvim_eval('FugitiveHead()') ~= '' then
    return self.colors.mode_arrow1 .. self.separators.arrow[1]
  end
  return self.colors.mode_arrow2 .. self.separators.arrow[1]
end

StatusLine.get_git_status = function(self)
  if vim.api.nvim_eval('FugitiveHead()') ~= '' then
    if self.powerline then
      -- return string.format('%s ', self.colors.active_dark .. '  ' .. vim.api.nvim_eval('FugitiveHead()') .. ' ' .. self.colors.git_arrow .. self.separators.arrow[1])
      return string.format('%s ', self.colors.active_dark .. '  ' .. vim.api.nvim_eval('FugitiveHead()') .. ' ' .. self.colors.git_arrow .. self.separators.arrow[1])
    end
    return string.format(' %s ', self.colors.active .. '  ' .. vim.api.nvim_eval('FugitiveHead()') .. ' |') -- 
  else
    return ' '
  end
end

StatusLine.get_filename = function(self)
  local bufname = vim.api.nvim_buf_get_name(0)
  local icon = require'nvim-web-devicons'.get_icon(bufname, string.match(bufname, '%a+$'), {}) or ''
  if icon then icon = icon .. ' ' end
  local filename = vim.api.nvim_buf_get_name(0)
  if not string.find(filename, "^term") then
    filename = path.new((path.new(filename)):make_relative()):shorten()
  else
    filename = "bash"
  end
  if self.powerline then
    return self.colors.active .. icon .. filename .. " %r%{&modified?'[+]':''}"
  end
  if self:get_git_status() == ' ' or self:get_git_status() == nil then
    return self.colors.active .. ' ' .. icon .. filename .. " %r%{&modified?'[+]':''}"
  end
  return self.colors.active .. icon .. filename .. " %r%{&modified?'[+]':''}"
end

StatusLine.get_filetype = function()
  local filetype = vim.bo.filetype
  filetype = string.format(' %s ', filetype):lower()
  return filetype
end

StatusLine.set_active = function(self)
  local mode = self.colors.mode .. self:get_current_mode()
  local git = self:get_git_status()
  local filename = self:get_filename()
  local filetype = self.get_filetype()

  -- return table.concat({
    -- mode, git, filename, '%=', lspstatus.hints(' ') .. ' ' .. lspstatus.warnings(' ') .. ' ' ..
    -- lspstatus.errors('✗ ') .. ' | ' .. '%p%%', filetype
  -- })
  return table.concat({
    mode, git, filename, '%=',
    lspstatus.status_hints() .. ' ',
    lspstatus.status_warnings() .. ' ',
    lspstatus.status_errors(),
    ' | ', '%p%%', filetype
  })
end

StatusLine.set_inactive = function(self)
  return self.colors.inactive .. '%= %t %r %='
end

StatusLine.active   = function() return StatusLine:set_active() end
StatusLine.inactive = function() return StatusLine:set_inactive() end

-- set statusline
vim.cmd('augroup StatusLine')
vim.cmd('au!')
vim.cmd('au WinEnter,BufEnter * setlocal statusline=%!v:lua.StatusLine.active()')
vim.cmd('au WinLeave,BufLeave * setlocal statusline=%!v:lua.StatusLine.inactive()')
vim.cmd('augroup END')

-- airline (when enabled)
vim.g['airline_powerline_fonts'] = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_theme'] = 'base16_ocean'
