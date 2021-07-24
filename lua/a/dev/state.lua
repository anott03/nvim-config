local State = {}
State.__index = State

function State:new(data)
  local obj = {}
  obj.data = data

  return setmetatable(obj, self)
end

function State:__tostring()
  return vim.inspect(self:get())
end

function State:get(key)
  if type(self.data) == 'table' and key then
    return self.data[key]
  end
  return self.data
end

function State:set(...)
  local params = {...}
  if #params > 1 then
    if type(self.data) ~= 'table' then
      error('data is not a table, but a key and a value were given')
    end

    local old_state = self.data[params[1]]
    self.data[params[1]] = params[2]
    self.on_change(params[1], old_state, self.data[params[1]])
    return
  end

  local old_state = self.data
  self.data = params[1]
  self.on_change(old_state, self.data)
end

function State:add_on_change_event(f)
  if not type(f) == 'function' then
    error('events handlers must take a function')
  end
  self.on_change = f
end

-- local var = State:new(1)
-- var:add_on_change_event(function()
  -- vim.notify('event emitted')
-- end)

-- var:set(2)

-- local var = State:new({
  -- a = 'a',
  -- b = 'b',
  -- c = 'c',
-- })

-- var:add_on_change_event(function(key, old_val, new_val)
  -- vim.notify(string.format('var[%s] :: %s --> %s', key, old_val, new_val))
-- end)
-- var:set('d', 'd')

return State
