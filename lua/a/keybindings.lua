---@diagnostic disable: different-requires
local vim = vim
local remap = REMAP

-- leader key is space
vim.g.mapleader = ' '

-- Telescope Mappings
require('a.plugins.telescope').mappings()
remap("n", "<leader>tt", "<CMD>PlenaryBustedDirectory lua/tests/automated/<CR>")

-- window movements
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
remap("n", "<C-c>", "<cmd>nohl<cr><C-c>")

remap("v", "J", ":m '>+1<CR>gv=gv");
remap("v", "K", ":m '<-2<CR>gv=gv");

-- indenting
remap("v", "<", "<gv")
remap("v", ">", ">gv")
-- disabling ex mode
remap("n", "Q", "<nop>")
-- file tree
remap("n", "<leader>e", "<CMD>Lex<CR>")

-- LSP related keybindings are in lsp-settings.lua

remap("n", "<leader>fc", "<cmd>foldclose<cr>")
remap("n", "<leader>fo", "<cmd>foldopen<cr>")

-- git
remap("n", "<leader>gb", "<CMD>Telescope git_branches<CR>")
remap("n", "<leader>gh", "<CMD>diffget //3<CR>")
remap("n", "<leader>gu", "<CMD>diffget //2<CR>")
remap("n", "<leader>gs", "<CMD>G<CR>")

-- termight
remap("n", "<leader>1", "<CMD>OpenTerm 1<CR>")
remap("n", "<leader>2", "<CMD>OpenTerm 2<CR>")
remap("n", "<leader>3", "<CMD>OpenTerm 3<CR>")

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

remap("n", "<leader>hq", ui.toggle_quick_menu)
remap("n", "<leader>ha", mark.add_file)
remap("n", "<leader>9", function () ui.nav_file(1) end)
remap("n", "<leader>8", function () ui.nav_file(2) end)
remap("n", "<leader>7", function () ui.nav_file(3) end)

remap("n", "<leader>f", function () ui.nav_file(1) end)
remap("n", "<leader>d", function () ui.nav_file(2) end)
remap("n", "<leader>s", function () ui.nav_file(3) end)
remap("n", "<leader>a", function () ui.nav_file(4) end)

-- trouble.nvim
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
