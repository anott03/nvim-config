local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')
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
      frecency = { workspaces = {
          ["conf"] = vim.loop.os_homedir() .. "/.config/",
          ["nvim"] = vim.loop.os_homedir() .. "/dev/nvim/",
        },
      },
    },
  })

  vim.cmd [[
    autocmd User TelescopePreviewerLoaded setlocal nonu nornu signcolumn=no
  ]]
end

local _theme = function(opts)
  return themes.get_ivy(opts or {})
end

local opts = _theme({
  previewer = false,
})

M.files = function()
  local _opts = vim.tbl_extend("keep", {
    show_untracked = false,
    recurse_submodules = true,
  }, opts)

  local ok = false
  -- if not git then ok = pcall(telescope.extensions.frecency.frecency, opts) end
  -- TODO: revisit this https://github.com/nvim-telescope/telescope.nvim/pull/521
  -- if ok then
    -- vim.api.nvim_feedkeys(':CWD: ', 'n', false)
  -- end
  if not ok then ok = pcall(builtin.git_files, _opts) end
  if not ok then builtin.find_files(opts) end
end

M.frecency = function()
  local ok = pcall(telescope.extensions.frecency.frecency, opts)
  if not ok then
    M.files()
  end
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

M.dotfiles = function()
  local _opts = {
    previewer = false,
    shorten_path = false,
    cwd = "~/repos/dotfiles",
    prompt_title = "Dotfiles",
    hidden = true,
  }
  _opts = _theme(_opts)

  builtin.fd(_opts)
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

M.neovim = function()
  local _opts = {
    -- previewer = false,
    shorten_path = false,
    cwd = "~/repos/neovim",
    prompt_title = "Local Extensions",
    hidden = true,
  }
  _opts = _theme(_opts)

  builtin.fd(_opts)
end

M.workspace_symbols = function()
  builtin.lsp_dynamic_workspace_symbols(_theme())
end

local function _remap(mode, lhs, rhs, o)
  if not lhs or not rhs or not mode then
    error("mode, lhs, and rhs are required")
  end

  o = o or {noremap = true}
  vim.api.nvim_set_keymap(mode, lhs, rhs, o)
end

local function generate_telescope_function(func)
  return function()
    reload('telescope')
    reload('a.plugins.telescope')
    local t = require('a.plugins.telescope')
    t.setup()
    t.mappings()
    func()
  end
end

TELESCOPE_FUNCTIONS = TELESCOPE_FUNCTIONS or {}
local function remap(mode, lhs, rhs, o)
  if type(rhs) == 'function' then
    rhs = generate_telescope_function(rhs)
    table.insert(TELESCOPE_FUNCTIONS, rhs)
    _remap(mode, lhs, "<cmd>lua TELESCOPE_FUNCTIONS[" .. #TELESCOPE_FUNCTIONS .. "]()<cr>", o)
  else
    _remap(mode, lhs, rhs, o)
  end
end

M.mappings = function()
  remap("n", "<leader><leader>", M.files)
  remap("n", "<leader>fd",       M.dotfiles)
  remap("n", "<leader>ff",       M.frecency)
  remap("n", "<leader>b",        M.bufs)
  remap("n", "<leader>ps",       M.grep)
  remap("n", "<leader>nv",       M.nvim)
  remap("n", "<leader>nn",       M.neovim)
  remap("n", "<leader>s",        M.workspace_symbols)
end

return M
