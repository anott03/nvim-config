local vim = vim
local nnoremap = require('astronauta.keymap').nnoremap
local vnoremap = require('astronauta.keymap').vnoremap
local M = {}

local remap = function(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {noremap = true})
end

M.setup = function()
  -- leader key is space
  vim.g.mapleader = ' '

  -- Telescope Mappings
  require('a.plugins.telescope').mappings()
  remap("n", "<leader>tt", "<CMD>PlenaryBustedDirectory lua/tests/automated/<CR>")

  -- window movements
  remap("n", "<leader>h", "<CMD>wincmd h<CR>")
  remap("n", "<leader>j", "<CMD>wincmd j<CR>")
  remap("n", "<leader>k", "<CMD>wincmd k<CR>")
  remap("n", "<leader>l", "<CMD>wincmd l<CR>")
  remap("n", "<C-h>", "<CMD>vertical resize +5<CR>")
  remap("n", "<C-l>", "<CMD>vertical resize -5<CR>")
  remap("n", "<C-k>", "<CMD>resize +5<CR>")
  remap("n", "<C-j>", "<CMD>resize -5<CR>") -- yank and put

  -- for some reason this works but the same bindings in lua don't
  vim.cmd(
  "nnoremap d \"_d\n" ..
  "vnoremap d \"_d\n"
  )

  remap("n", "<ESC>", "<CMD>nohl<CR><ESC>")
  remap("n", "<leader>S", "<CMD>lua SO()<CR>")

  -- indenting
  remap("v", "<", "<gv")
  remap("v", ">", ">gv")
  -- disabling ex mode
  remap("n", "Q", "<nop>")
  -- file tree
  remap("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")

  -- lsp
  nnoremap({"gd", vim.lsp.buf.definition})
  nnoremap({"gi", vim.lsp.buf.implementation})
  nnoremap({"gr", vim.lsp.buf.references})
  -- nnoremap({"K", vim.lsp.buf.hover})
  -- vnoremap({"K", vim.lsp.buf.hover})
  nnoremap({"K", require('lspsaga.hover').render_hover_doc})
  vnoremap({"K", require('lspsaga.hover').render_hover_doc})
  nnoremap({"<leader>K", require('lspsaga.diagnostic').show_line_diagnostics})
  -- remap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', {expr = true})
  -- remap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', {expr = true})

  nnoremap({"<leader>w",  vim.lsp.diagnostic.set_loclist})
  nnoremap({"<leader>rr", require('a.lsp-settings').lsp_rename})
  nnoremap({"<leader>a",  require('a.lsp-settings').lsp_code_actions})

  -- git
  remap("n", "<leader>gb", "<CMD>Telescope git_branches<CR>")
  remap("n", "<leader>gh", "<CMD>diffget //3<CR>")
  remap("n", "<leader>gu", "<CMD>diffget //2<CR>")
  remap("n", "<leader>gs", "<CMD>G<CR>")
  -- git-worktree
  nnoremap({"<leader>gw", require('a.plugins.telescope').git_worktree})
  nnoremap({"<leader>gc", require('a.plugins.git-worktree').create_worktree})
  nnoremap({"<leader>gr", require('a.plugins.git-worktree').delete_worktree})

  -- termight
  remap("n", "<leader>1", "<CMD>OpenTerm 1<CR>")
  remap("n", "<leader>2", "<CMD>OpenTerm 2<CR>")
  remap("n", "<leader>3", "<CMD>OpenTerm 3<CR>")

  -- HARPOON
  nnoremap({'<leader>fa', require("harpoon.mark").add_file})
  nnoremap({'<leader>fq', require("harpoon.ui").toggle_quick_menu})
  nnoremap({'<leader>9', function() require("harpoon.ui").nav_file(1) end})
  nnoremap({'<leader>8', function() require("harpoon.ui").nav_file(2) end})
  nnoremap({'<leader>7', function() require("harpoon.ui").nav_file(3) end})

  -- undotree
  remap("n", "<leader>u", "<CMD>UndotreeToggle<CR>")

  -- refactoring
  require('a.plugins.refactoring').set_keymaps()
end

return M
