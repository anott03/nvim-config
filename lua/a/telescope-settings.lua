local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

require('telescope').setup({
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',

    winblend = 0,
    preview_cutoff = 120,

    layout_strategy = 'horizontal',
    layout_defaults = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_width = 0.6
      }
    },

    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    prompt_position = "top",
    color_devicons = "true",

    mappings = {
      i = {
        ["<C-s>"] = actions.select_horizontal,
        ["<esc>"] = actions.close,
      }
    },
  },

  borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

  file_sorter = sorters.get_fzy_sorter,

  file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
  grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
  qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
})

return {
  tele_bufs = function()
    require('telescope.builtin').buffers()
  end,

  tele_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require'telescope.builtin'.git_files, opts)
    if not ok then require'telescope.builtin'.find_files(opts) end
  end,

  tele_grep = function()
    local input = vim.fn.input("Grep for > "):gsub("%s+", "")
    if input ~= '' then
      require('telescope.builtin').grep_string({
        search = input
      })
    end
  end
}
