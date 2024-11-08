P = function(x)
  print(vim.inspect(x))
end

function RUN_IN_POPUP(cmd)
  local float = require('plenary.window.float').percentage_range_window
  local bufnr = vim.api.nvim_create_buf(false, false)

  local opts = float(0.75, 0.6, { winblend = 1 }, {})

  vim.api.nvim_set_option_value('winhl', 'Normal:Normal', { win = opts.win_id })
  vim.api.nvim_set_option_value('winhl', 'Normal:Normal', { win = opts.border_win_id })

  vim.api.nvim_buf_set_keymap(opts.bufnr, 'n', '<esc>', '<cmd>q!<cr>', {})
  vim.api.nvim_buf_set_keymap(opts.bufnr, 'n', 'q', '<cmd>q!<cr>', {})

  vim.fn.termopen(cmd)
end

return {
  RUN_IN_POPUP
}
