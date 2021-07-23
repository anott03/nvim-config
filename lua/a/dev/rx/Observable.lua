local Observable = {}
Observable.__index = Observable

function Observable:new(subscriber)
  local obj = {}
  if (subscriber) then
    obj._subscriber = subscriber
  end
  return setmetatable(obj, Observable)
end

function Observable:subscribe()
end

return Observable
