local async = require('plenary.async_lib')

local f = async.wrap(function(params)
  return params
end, 'vararg')

-- print(vim.inspect(
  -- f()(3)
-- ))

local g = async.async(function(params)
  print(vim.inspect(params))
end)

local future = g()

async.run(future, function()
  print('done')
end)
