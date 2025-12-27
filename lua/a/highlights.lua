-- COLORSCHEME = "rose-pine"
COLORSCHEME = "catppuccin-mocha"
-- COLORSCHEME = "gruvbox"
vim.cmd("colo " .. COLORSCHEME)

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
      hi NormalNC guibg=None
      hi SignColumn guibg=None
  ]]
  update_highlights()
  TRANSPARENCY = true
end

TRANSPARENCY = false

REMAP("n", "<leader>vt", TOGGLE_TRANSPARENCY)
update_highlights()
