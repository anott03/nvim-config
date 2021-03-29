local vim = vim
local remap = function(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {noremap = true})
end

-- leader key is space
vim.g.mapleader = ' '
local function telescope(cmd)
  require('plenary.reload').reload_module('telescope')
  vim.cmd('Telescope ' .. cmd)
end

-- fuzzy file picker
-- use Telescope git_files if there is a .git directory present
-- otherwise use Telescope find_files
local is_git_repo = '[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1'
if (os.execute(is_git_repo) == 0) then
  -- remap("n", "<leader><leader>", "<CMD>Telescope git_files<CR>")
  remap("n", "<leader><leader>", "<CMD>lua require('keybindings').telescope('git_files')<CR>")
else
  -- remap("n", "<leader><leader>", "<CMD>Telescope find_files<CR>")
  remap("n", "<leader><leader>", "<CMD>lua require('keybindings').telescope('find_files')<CR>")
end

remap("n", "<leader>b", "<CMD>Telescope buffers<CR>")
remap("n", "<leader>ps", "<CMD>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ') })<CR>")

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
-- TODO add the loop I had in init.vim for using registers
-- remap("n", "p", "\"0p", {});
-- remap("n", "P", "\"0P", {});
-- remap("n", "dd", '"_dd', {});
-- remap("v", "d", '"_d', {});

-- for some reason this works but the same bindings in lua don't
vim.cmd(
"nnoremap d \"_d\n" ..
"vnoremap d \"_d\n"
)

remap("<ESC>", "<CMD>nohl<CR><ESC>")

-- indenting
remap("v", "<", "<gv")
remap("v", ">", ">gv")
-- disabling ex mode
remap("n", "Q", "<nop")
-- file tree
remap("n", "<leader>e", "<CMD>Lex<CR>")

-- lsp
remap("n", "gtd", "<CMD>lua vim.lsp.buf.definition()<CR>")
remap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>")
remap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>")
remap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>")
remap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', {expr = true})
remap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', {expr = true})

remap("n", "<leader>w", '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>')

-- remap("n", "<leader>K", '<CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
remap("n", "<leader>K", "<CMD>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>")
remap("n", "<leader>rr", "<CMD>lua require('lspsaga.rename').rename()<CR>")
remap("n", "<leader>a", "<CMD>lua require('lspsaga.codeaction').code_action()<CR>")
remap("n", "<leader>gf", "<CMD>lua require('lspsaga.provider').lsp_finder()<CR>")
remap("n", "K", "<CMD>lua require('lspsaga.hover').render_hover_doc()<CR>")
remap("n", "<leader>gk", "<CMD>lua require('lspsaga.signaturehelp').signature_help()<CR>")
remap("n", "gd", "<CMD>lua require('lspsaga.provider').preview_definition()<CR>")

-- coc.nvim
-- remap("n", "<leader>rn", "<Plug>(coc-rename)")
-- remap("n", "<leader>w", "<CMD>CocSearch <C-R>=expand('<cword>')<CR><CR>")

-- git
-- remap("n", "<leader>gc", "<CMD>GBranches<CR>")
remap("n", "<leader>gc", "<CMD>Telescope git_branches<CR>")
remap("n", "<leader>gh", "<CMD>diffget //3<CR>")
remap("n", "<leader>gu", "<CMD>diffget //2<CR>")
remap("n", "<leader>gs", "<CMD>G<CR>")

-- termight
remap("n", "<leader>1", "<CMD>OpenTerm 1<CR>")
remap("n", "<leader>2", "<CMD>OpenTerm 2<CR>")
remap("n", "<leader>3", "<CMD>OpenTerm 3<CR>")
remap("n", "<leader>4", "<CMD>OpenTerm 4<CR>")

-- undotree
remap("n", "<leader>u", "<CMD>UndotreeToggle<CR>")

return {
  telescope = telescope,
}
