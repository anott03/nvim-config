function foo(num, tbl)
  if num > 0 then
    local x = {}
    for i, k in pairs(tbl) do
      table.insert(x, {i = i, k = k})
    end
    return x
  else
    return {}
  end
end
