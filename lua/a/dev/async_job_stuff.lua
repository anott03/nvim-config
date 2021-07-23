local async_lib = require('plenary.async_lib')
local Job = require('plenary.job')

local async = async_lib.async
local await = async_lib.await

local g = async(function(params)
  Job:new({
    command = 'sleep',
    args = { '3' },
    on_exit = function()
      print(vim.inspect(params))
    end,
  }):sync()
end)

await(g(3))
