-- require('nvim_comment').setup({
--   comment_empty = false,
--   create_mappings = true,
--   line_mapping = "<leader>cc",
--   oeprator_mapping = "<leader>c"
-- })

require('Comment').setup({
  toggler = {
    -- this plugin does not evaluate <leader> to space
    line = ' cc',
    block = ' bc',
  },
  opleader = {
    line = ' c',
    block = ' b',
  }
})
