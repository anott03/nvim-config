COLORSCHEME = "gruvbox-baby"
vim.cmd("colo " .. COLORSCHEME)

local set_hl = function(group, options)
  local bg = options.bg == nil and '' or 'guibg=' .. options.bg
  local fg = options.fg == nil and '' or 'guifg=' .. options.fg
  local gui = options.gui == nil and '' or 'gui=' .. options.gui
  vim.cmd(string.format('hi %s %s %s %s', group, bg, fg, gui))
end

local update_highlights = function ()
    require('a.plugins.cmp').custom_highlights()
    -- require('a.statusline').statuslin_highlights()
end

TOGGLE_TRANSPARENCY = function ()
  if TRANSPARENCY then
    vim.cmd("colo " .. COLORSCHEME)
    TRANSPARENCY = false
    update_highlights()
    return
  end
  vim.cmd [[
      hi Normal guibg=None
      hi SignColumn guibg=None
  ]]
  update_highlights()
  TRANSPARENCY = true
end

TRANSPARENCY = false
TOGGLE_TRANSPARENCY()

local remap = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or {noremap = true})
end
remap("n", "<leader>vt", TOGGLE_TRANSPARENCY)