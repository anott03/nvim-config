RELOAD('a.dev.state')
local State = require('a.dev.state')

local var = State:new(17)

var:add_on_change_event(function(old, new)
  print(string.format("%s --> %s", old, new))
end)

var:set(18)
print(var:get())
