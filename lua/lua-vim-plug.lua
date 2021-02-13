local vim = vim

local addPlugin = function(name, opts)
  local cmd = 'Plug ' .. '\'' .. name ..'\''
  if (opts) then
    cmd = cmd .. ', {'
    for k, v in pairs(opts) do
      cmd = cmd .. '\'' .. k .. '\'' .. ':' .. v .. ', '
    end
    cmd = cmd .. '}'
  end

  vim.cmd(cmd)
end

local plugBegin = function()
  vim.cmd('call plug#begin(stdpath(\'data\') . \'/plugged\')')
end

local plugEnd = function()
  vim.cmd('call plug#end()')
end

local installPlugins = function(plugins)
  plugBegin()
  for i, _ in pairs(plugins) do
    addPlugin(plugins[i][1], plugins[i][2] or nil)
  end
  plugEnd()
end

return installPlugins
