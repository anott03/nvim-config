local api = vim.api
local Job = require('plenary.job')

local function location_window(options)
    local default_options = {
        relative = "editor",
        style = "minimal",
        width = 30,
        height = 15,
        row = 2,
        col = 2,
        border = {
          {"╭", "Normal"},
          {"─", "Normal"},
          {"╮", "Normal"},
          {"│", "Normal"},
          {"╯", "Normal"},
          {"─", "Normal"},
          {"╰", "Normal"},
          {"│", "Normal"},
        },
    }
    options = vim.tbl_extend("keep", options, default_options)

    local bufnr = options.bufnr or api.nvim_create_buf(false, true)
    local win_id = api.nvim_open_win(bufnr, true, options)
    api.nvim_win_set_option(win_id, 'winhl', 'Normal:Normal')

    return {
        bufnr = bufnr,
        win_id = win_id,
    }
end

-- ACTIVE_NOTIFICATIONS = ACTIVE_NOTIFICATIONS or {}

local function create_notification(text)
  local win_stats = api.nvim_list_uis()[1]
  local win_width = win_stats.width

  local prev_win = api.nvim_get_current_win()

  local info = location_window({
      width = 20,
      height = 2,
      row = 1,
      col = win_width - 21,
  })

  api.nvim_buf_set_lines(
      info.bufnr, 0, 5, false, { "!!! Notification", text }
  )
  api.nvim_set_current_win(prev_win)
  return {
    info.bufnr,
    info.win_id
  }
end

NOTIFICAION_QUEUE = {}
Notification = {}

function Notification:new(text, lifetime)
  self.text = text
  self.lifetime = lifetime
end

function Notification:render()
  create_notification(self.text)

  -- vim.defer_fn(CLOSE_NOTIFICATION, self.lifetime or 3000)
  vim.defer_fn(function()
    self.close()
  end, self.lifetime or 3000)
end

function Notification:close()
  if not self.bufnr then
    print('notification is not currently being rendered')
    return
  end

  api.nvim_buf_delete(self.bufnr)
  self.bufnr = nil
end




function CLOSE_NOTIFICATION()
  if #NOTIFICAION_QUEUE == 0 then
    print("no open notifications to close")
    return -1
  end

  local current_notification = NOTIFICAION_QUEUE[#NOTIFICAION_QUEUE]
  api.nvim_buf_delete(current_notification[1], { force = true })
end
