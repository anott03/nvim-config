local vim = vim

-- highlight yank
vim.cmd("augroup highlight_yank")
vim.cmd("autocmd!")
vim.cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()")
vim.cmd("augroup END")

-- nvim tree stuff
vim.cmd("augroup nvimtreestuff")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType nvimtree set signcolumn=no")
vim.cmd("augroup END")
