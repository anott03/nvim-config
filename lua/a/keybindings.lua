local vim = vim
local M = {}

local remap = function(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {noremap = true})
end

M.setup = function()
  -- leader key is space
  vim.g.mapleader = ' '

  -- Telescope Mappings
  remap("n", "<leader><leader>", "<CMD>lua require('a.plugins.telescope').tele_files()<CR>")
  remap("n", "<leader>b", "<CMD>lua require('a.plugins.telescope').tele_bufs()<CR>")
  remap("n", "<leader>ps", "<CMD>lua require('a.plugins.telescope').tele_grep()<CR>")
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

  -- indenting
  remap("v", "<", "<gv")
  remap("v", ">", ">gv")
  -- disabling ex mode
  remap("n", "Q", "<nop>")
  -- file tree
  remap("n", "<leader>e", "<CMD>Lex<CR>")

  -- lsp
  remap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>")
  remap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>")
  remap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>")
  remap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>")
  remap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', {expr = true})
  remap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', {expr = true})

  remap("n", "<leader>w", '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>')
  remap("n", "<leader>rr", "<CMD>lua require('a.lsp-settings').lsp_rename()<CR>")
  remap("n", "<leader>a", "<CMD>lua require('a.lsp-settings').lsp_code_actions()<CR>")
  remap("n", "<leader>K", "<CMD>Lspsaga show_line_diagnostics<CR>")
  remap("n", "K", "<CMD>Lspsaga hover_doc<CR>")

  -- git
  remap("n", "<leader>gb", "<CMD>Telescope git_branches<CR>")
  remap("n", "<leader>gh", "<CMD>diffget //3<CR>")
  remap("n", "<leader>gu", "<CMD>diffget //2<CR>")
  remap("n", "<leader>gs", "<CMD>G<CR>")
  -- git-worktree
  remap("n", "<leader>gw", "<CMD>lua require('a.plugins.telescope').tele_git_worktree()<CR>")
  remap("n", "<leader>gc", "<cmd>lua require('a.plugins.git-worktree').create_worktree()<cr>")
  remap("n", "<leader>gr", "<cmd>lua require('a.plugins.git-worktree').delete_worktree()<cr>")

  -- termight
  remap("n", "<leader>1", "<CMD>OpenTerm 1<CR>")
  remap("n", "<leader>2", "<CMD>OpenTerm 2<CR>")
  remap("n", "<leader>3", "<CMD>OpenTerm 3<CR>")
  remap("n", "<leader>4", "<CMD>OpenTerm 4<CR>")

  -- undotree
  remap("n", "<leader>u", "<CMD>UndotreeToggle<CR>")
end

return M
