require('a.autocmds.highlight_yank')
require('a.autocmds.rust_on_save')

local levels = {
  errors = vim.diagnostic.severity.ERROR,
  warnings = vim.diagnostic.severity.WARN,
  info = vim.diagnostic.severity.INFO,
  hints = vim.diagnostic.severity.HINT,
}

local function get_all_diagnostics(bufnr)
  local result = {}
  for k, level in pairs(levels) do
    result[k] = #vim.diagnostic.get(bufnr, { severity = level })
  end

  return result
end

vim.api.nvim_create_autocmd({"DiagnosticChanged", "BufEnter"}, {
    group = vim.api.nvim_create_augroup("LspRuler", { clear = true}),
    pattern = "*",
    callback = function()
        local d = get_all_diagnostics(0)
        local errstring = "E:".. d.errors .. " W:" .. d.warnings
        local formatstring = "%25(%=%=" .. errstring .. " | %l,%c | %P%)"
        vim.o.rulerformat = formatstring
    end
})
