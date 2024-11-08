local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')
local reload = require('plenary.reload').reload_module

local M = {}

M.setup = function()
  pcall(telescope.load_extension, 'fzy_native')
  pcall(telescope.load_extension, 'git_worktree')
  pcall(telescope.load_extension, 'ui-select')
  pcall(telescope.load_extension, 'harpoon')
  pcall(telescope.load_extension, 'git_worktree')

  telescope.setup({
    defaults = {
      prompt_prefix = '❯ ',
      selection_caret = '❯ ',

      winblend = 0,

      layout_strategy = 'horizontal',
      layout_config = {
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
        prompt_position = "top",
        preview_cutoff = 120,
      },

      selection_strategy = "reset",
      sorting_strategy = "ascending",
      scroll_strategy = "cycle",
      color_devicons = true,
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

      mappings = {
        i = {
          ["<C-s>"] = actions.select_horizontal,
          ["<esc>"] = actions.close,
          ["<C-t>"] = require("trouble.sources.telescope").open,
        },
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
      ["ui-select"] = {
        themes.get_dropdown {
          winblend = 10,
          border = true,
          previewer = false,
          shorten_path = false,
        }
      }
    },
  })

  vim.cmd [[
    autocmd User TelescopePreviewerLoaded setlocal nonu nornu signcolumn=no
  ]]
end

local _theme = function(opts)
  -- return themes.get_ivy(opts or {})
  return opts
end

local opts = _theme({
  previewer = false,
})

M.files = function()
  local _opts = vim.tbl_extend("keep", {
    show_untracked = true,
    recurse_submodules = false,
  }, opts)

  local ok = false
  if not ok then ok = pcall(builtin.git_files, _opts) end
  if not ok then builtin.find_files(opts) end
end

M.bufs = function()
  reload('telescope')
  require('telescope.builtin').buffers(_theme())
end

M.grep = function()
  local input = vim.fn.input("Grep for > "):gsub("%s+", "")
  if input ~= '' then
    require('telescope.builtin').grep_string({
      search = input
    })
  end
end

M.git_worktree = function()
  reload('telescope')
  telescope.extensions.git_worktree.git_worktrees()
end

M.nvim = function()
  local _opts = {
    -- previewer = false,
    shorten_path = false,
    cwd = "~/dev/nvim",
    prompt_title = "Local Extensions",
    hidden = true,
  }
  _opts = _theme(_opts)

  builtin.fd(_opts)
end

M.workspace_symbols = function()
  builtin.lsp_dynamic_workspace_symbols(_theme())
end

local function generate_telescope_function(func)
  return function()
    reload('telescope')
    reload('a.plugins.telescope')
    M.setup()
    M.mappings()
    func()
  end
end

M.mappings = function()
  vim.keymap.set("n", "<leader><leader>", generate_telescope_function(M.files))
  vim.keymap.set("n", "<leader>b",        generate_telescope_function(M.bufs))
  vim.keymap.set("n", "<leader>ps",       generate_telescope_function(M.grep))
  vim.keymap.set("n", "<leader>nv",       generate_telescope_function(M.nvim))
  --vim.keymap.set("n", "<leader>ws",       generate_telescope_function(M.workspace_symbols))
  vim.keymap.set("n", "<leader>gw",       generate_telescope_function(M.git_worktree))
end

return M
