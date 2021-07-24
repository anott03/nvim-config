RELOAD('a.dev.rx.Observable')
local Observable = require('a.dev.rx.Observable')

local o = Observable:new({
  next = function(value)
    print(vim.inspect(value))
  end,
  complete = function()
    print("completed")
  end
})

o:subscribe()
