local telescope = require('telescope')
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local reload = require('plenary.reload').reload_module

local M = {}

M.setup = function()
  pcall(telescope.load_extension, 'fzy_native')
  pcall(telescope.load_extension, 'frecency')
  pcall(telescope.load_extension, 'git_worktree')

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
      color_devicons = true,
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

      mappings = {
        i = {
          ["<C-s>"] = actions.select_horizontal,
          ["<esc>"] = actions.close,
        }
      },

      file_sorter = sorters.get_fzy_sorter,

      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },

    extensions = {
      fzy_native = {
        override_generic_sorter = true,
        override_file_sorter = true,
      },
      frecency = {
        workspaces = {
          ["conf"] = vim.loop.os_homedir() .. "/.config/",
          ["nvim"] = vim.loop.os_homedir() .. "/dev/nvim/",
        },
      },
    },
  })
end

M.tele_bufs = function()
  reload('telescope')
  require('telescope.builtin').buffers()
end

M.tele_files = function()
  reload('telescope')
  local opts = {
    previewer = false,
    layout_strategy = "horizontal",
  }

  local ok = pcall(telescope.extensions.frecency.frecency, opts)
  -- TODO: revisit this
  -- https://github.com/nvim-telescope/telescope.nvim/pull/521
  if ok then
    vim.api.nvim_feedkeys(':CWD: ', 'n', false)
  end
  if not ok then ok = pcall(require'telescope.builtin'.git_files, opts) end
  if not ok then require'telescope.builtin'.find_files(opts) end
end

M.tele_grep = function()
  reload('telescope')
  local input = vim.fn.input("Grep for > "):gsub("%s+", "")
  if input ~= '' then
    require('telescope.builtin').grep_string({
      search = input
    })
  end
end

M.tele_git_worktree = function()
  reload('telescope')
  telescope.extensions.git_worktree.git_worktrees()
end

return M
