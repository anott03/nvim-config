local path = require('plenary.path')
local lspstatus = require('lsp-status')
lspstatus.config({ indicator_errors = '✗', indicator_warnings = '',
  indicator_hint = '',
  status_symbol = ''
})

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function filepath()
  local bufname = vim.api.nvim_buf_get_name(0)
  local icon = require'nvim-web-devicons'.get_icon(bufname, string.match(bufname, '%a+$'), {}) or ''
  if icon then icon = icon .. ' ' end
  local filename = vim.api.nvim_buf_get_name(0)
  if not string.find(filename, "^term") then
    filename = path.new((path.new(filename)):make_relative()):shorten()
  else
    filename = "bash"
  end
  return ' ' .. icon .. filename .. " %r%{&modified?'[+]':''}"
end

local function lsp()
  return lspstatus.status()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P "
end

local function git_status()
  if vim.api.nvim_eval('FugitiveHead()') ~= '' then
    return string.format('%s ', '  ' .. vim.api.nvim_eval('FugitiveHead()')) -- 
  else
    return ' '
  end
end

Statusline = {}
Statusline.active = function ()
  return table.concat({
    "%#Statusline#",
    mode(),
    -- "%#Statusline#",
    "%=",
    filepath(),
    "%=%#StatusLineExtra#",
    lsp(),
    "|",
    lineinfo(),
    "|",
    git_status()
  })
end

Statusline.inactive = function ()
  return "%=%F"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

-- return {
--     statuslin_highlights = function ()
--         vim.api.nvim_set_hl(0, "StatuslineMode", { fg = "#000000", bg = "#58b5a8", bold = true })
--     end
-- }
