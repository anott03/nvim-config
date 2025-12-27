vim.g.pioConfig ={
  lsp = 'clangd',           -- value: clangd | ccls 
  clangd_source = 'ccls',    -- value: ccls | compiledb, For detailed explation check :help platformio-clangd_source
  menu_key = '<leader>\\',  -- replace this menu key  to your convenience
  debug = false             -- enable debug messages
} 
local pok, platformio = pcall(require, 'platformio')
if pok then platformio.setup(vim.g.pioConfig) end
