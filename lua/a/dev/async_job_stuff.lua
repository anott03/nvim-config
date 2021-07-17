local async_lib = require('plenary.async_lib')
local async = async_lib.async
local await = async_lib.await

local f = async_lib.wrap(function(params)
  return params
end, 'vararg')

-- print(vim.inspect(
  -- f()(3)
-- ))

local g = async(function(params)
  print(vim.inspect(params))
end)

-- async.run(future, function()
  -- print('done')
-- end)
await(g(3))
