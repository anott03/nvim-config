-- local Job = require('plenary.job')
local uv = vim.loop

local async
async = uv.new_async(function()
  print("async operation ran")
  async:close()
end)

vim.defer_fn(function()
  async:send()
end, 3000)
