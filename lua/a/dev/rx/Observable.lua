local Observable = {}
Observable.__index = Observable

function Observable:new(subscriber)
  local obj = {}
  -- print(vim.inspect(subscriber))
  if (subscriber) then
    obj._subscriber = subscriber
  end
  return setmetatable(obj, Observable)
end

function Observable:subscribe()
  local test_data = 13
  self._subscriber.next(test_data)
  if self._subscriber.complete then
    self._subscriber.complete()
  end
end

return Observable
