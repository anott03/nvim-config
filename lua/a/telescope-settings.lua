local telescope = require('telescope')
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

telescope.load_extension('fzy_native')
telescope.load_extension('frecency')

telescope.setup({
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
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    prompt_position = "top",
    color_devicons = "true",
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

    mappings = {
      i = {
        ["<C-s>"] = actions.select_horizontal,
        ["<esc>"] = actions.close,
      }
    },
  },

  file_sorter = sorters.get_fzy_sorter,

  file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
  grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
  qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
})

local M = {}

M.tele_bufs = function()
  require('telescope.builtin').buffers()
end

M.tele_files = function()
  local opts = {
    previewer = false,
    layout_strategy = "center",
    results_height = 30,
  }

  local ok = pcall(telescope.extensions.frecency.frecency, opts)
  if not ok then ok = pcall(require'telescope.builtin'.git_files, opts) end
  if not ok then require'telescope.builtin'.find_files(opts) end
end

M.tele_grep = function()
  local input = vim.fn.input("Grep for > "):gsub("%s+", "")
  if input ~= '' then
    require('telescope.builtin').grep_string({
      search = input
    })
  end
end

M.tele_git_worktree = function()
  telescope.extensions.git_worktree.git_worktrees()
end

return M
