local plenary = require('plenary')
local api = vim.api

local function create_window(opts)
  local _opts = {
    relative = 'editor',
    style    = 'minimal',
    width = 15,
    height = 2,
    row = 2,
    col = 2
  }
  opts = vim.tbl_extend('keep', opts or {}, _opts)

  local bufnr = api.nvim_create_buf(false, false)
  local win = api.nvim_open_win(bufnr, true, opts)

  return win
end

local function create_notification(text)
  create_window()

  return text
end

create_notification("this is a notification")
