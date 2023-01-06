local vim = vim

local remap = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or {noremap = true})
end

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

-- indenting
remap("v", "<", "<gv")
remap("v", ">", ">gv")
-- disabling ex mode
remap("n", "Q", "<nop>")
-- file tree
remap("n", "<leader>e", "<CMD>Lex<CR>")

-- LSP related keybindings are in lsp-settings.lua

-- git
remap("n", "<leader>gb", "<CMD>Telescope git_branches<CR>")
remap("n", "<leader>gh", "<CMD>diffget //3<CR>")
remap("n", "<leader>gu", "<CMD>diffget //2<CR>")
remap("n", "<leader>gs", "<CMD>G<CR>")

-- termight
remap("n", "<leader>1", "<CMD>OpenTerm 1<CR>")
remap("n", "<leader>2", "<CMD>OpenTerm 2<CR>")
remap("n", "<leader>3", "<CMD>OpenTerm 3<CR>")

-- other
remap("n", "<leader>vt", TOGGLE_TRANSPARENCY)
