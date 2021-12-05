function PYTHON_RUN() RUN_IN_POPUP("python3 " .. vim.fn.expand("%")) end
vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>lua PYTHON_RUN()<CR>', {})
