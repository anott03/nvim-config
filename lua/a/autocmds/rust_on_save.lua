local vim = vim

CARGO_TEST_BUFFER = nil
RUST_ON_SAVE_COMMAND = "run"

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("RustOnSave", { clear = true }),
  pattern = "*.rs",
  callback = function()
    -- local bufnr = vim.api.nvim_create_buf(false, true)
    -- vim.cmd.new()
    -- vim.api.nvim_set_current_buf(bufnr)

    -- vim.fn.jobstart({ "cargo", "test" }, {
      -- stdout_buffered = true,
      -- on_stdout = function(_, data)
        -- if data then
          -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        -- end
      -- end,
      -- on_stderr = function(_, data)
        -- if data then
          -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        -- end
      -- end
    -- })
    if CARGO_TEST_BUFFER then
      pcall(vim.api.nvim_buf_delete, CARGO_TEST_BUFFER, { force = true })
    end
    vim.cmd("Cargo " .. RUST_ON_SAVE_COMMAND)
    CARGO_TEST_BUFFER = vim.api.nvim_get_current_buf()
    vim.api.nvim_win_set_height(0, math.floor(vim.o.lines * 0.3))
  end
})
