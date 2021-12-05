function RUST_RUN() RUN_IN_POPUP("cargo run") end
function RUST_TEST() RUN_IN_POPUP("cargo test") end

vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>lua RUST_RUN()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>T', '<cmd>lua RUST_TEST()<CR>', {})
