local vim = vim

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("RustOnSave", { clear = true }),
  pattern = "*.rs",
  callback = function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.cmd.new()
    vim.api.nvim_set_current_buf(bufnr)

    vim.fn.jobstart({ "cargo", "run" }, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end,
      on_stderr = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end
    })
  end
})
