function PYTHON_RUN() RUN_IN_POPUP("python3 " .. vim.fn.expand("%")) end
vim.keymap.set('n', '<leader>R', PYTHON_RUN, {})
