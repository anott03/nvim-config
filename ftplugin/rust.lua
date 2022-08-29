function RUST_RUN() RUN_IN_POPUP("cargo run") end
function RUST_TEST() RUN_IN_POPUP("cargo test") end

vim.keymap.set('n', '<leader>R', RUST_RUN, {})
vim.keymap.set('n', '<leader>T', RUST_TEST, {})
