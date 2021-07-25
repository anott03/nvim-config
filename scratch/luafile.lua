local percentage_range_window = require('plenary.window.float').percentage_range_window

local run_luafile = function()
  local w = percentage_range_window(0.5, 0.5)
  local bufnr = w.bufnr
  print(vim.inspect(bufnr))
end

run_luafile()

return run_luafile
