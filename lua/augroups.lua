local vim = vim

-- highlight yank
vim.cmd("augroup highlight_yank")
vim.cmd("autocmd!")
vim.cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()")
vim.cmd("augroup END")
