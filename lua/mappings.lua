local utils = require("utils")
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap
local silent = { silent = true }
local sexpr = { silent = true, expr = true }

vim.cmd([[command W :w]])
vim.cmd([[command Q :q]])
vim.cmd([[command Wq :wq]])

-- paste/delete and keep register clean
vnoremap("<leader>p", '"_dP')
vnoremap("<leader>d", '"_d')

-- better indenting
vnoremap("<", "<gv", silent)
vnoremap(">", ">gv", silent)

-- easier exit insert mode in the terminal
utils.tnoremap("<Esc>", "<C-\\><C-n>")

-- keeps jumps centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("<leader>J", "mzJ`z")

nnoremap("<leader>pp", ":echo expand('%:p')<CR>")

-- unbinding
nnoremap("<C-F>", "")
------------------------                  -------------------------
------------------------ Plugin Specifics -------------------------
------------------------                  -------------------------

-- format code
nnoremap("<Leader>fm", ":Neoformat<CR>", silent)

-- Telescope
nnoremap("<C-p>", ":lua require('setup.telescope').find_files()<CR>")
nnoremap("<C-e>", ":lua require('setup.telescope').file_browser()<CR>", silent)
nnoremap("<leader>fw", ":Telescope live_grep<CR>", silent)
nnoremap("<leader>gc", ":Telescope git_commits<CR>", silent)
nnoremap("<leader>fb", ":Telescope buffers<CR>", silent)
nnoremap("<leader>fh", ":Telescope help_tags<CR>", silent)
nnoremap("<leader>rc", ":lua require'setup.telescope'.search_dotfiles()<CR>", silent)
nnoremap("<leader>fg", ":lua require'setup.telescope'.git_worktrees()<CR>", silent)
nnoremap("<leader>ct", ":lua require'setup.telescope'.create_git_worktree()<CR>", silent)
nnoremap("<leader>fy", ":lua require'setup.telescope'.neoclip()<CR>", silent)
nnoremap("<leader>ff", ":lua require'setup.telescope'.curbuf()<CR>", silent)
nnoremap("<leader>fc", ":Telescope commands<CR>", silent)

-- Lsp
nnoremap("gD", ":lua vim.lsp.buf.declaration()<CR>", silent)
nnoremap("K", ":lua vim.lsp.buf.hover()<CR>", silent)
nnoremap("<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", silent)
nnoremap("<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", silent)
nnoremap("<leader>rn", ":lua vim.lsp.buf.rename()<CR>", silent)
nnoremap("<leader>d", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", silent)
-- Lsp Tele
nnoremap("gd", ":Telescope lsp_definitions<CR>", silent)
nnoremap("gr", ":Telescope lsp_references<CR>", silent)
nnoremap("<leader>ca", ":lua require('setup.telescope').lsp_code_actions()<CR>", silent)
nnoremap("<leader>gi", ":Telescope lsp_implementations<CR>", silent)
nnoremap("<leader>fs", ":lua require('setup.telescope').get_symbols()<CR>", silent)
nnoremap("<leader>tw", ":Telescope diagnostics bufnr=0<CR>", silent)
nnoremap("<leader>td", ":Telescope diagnostics<CR>", silent)

-- Refactoring
nnoremap("<leader>rt", ":norm! V<CR> :lua require'setup.telescope'.refactor()<CR>", silent)
vnoremap("<leader>rt", ":lua require'setup.telescope'.refactor()<CR>", silent)

-- Harpoon
nnoremap("<leader>a", ":lua require'harpoon.mark'.add_file()<CR>", silent)
nnoremap("<leader>e", ":lua require'harpoon.ui'.toggle_quick_menu()<CR>", silent)

nnoremap("<leader>hn", ":lua require('harpoon.ui').nav_file(1)<CR>")
nnoremap("<leader>he", ":lua require('harpoon.ui').nav_file(2)<CR>")
nnoremap("<leader>ho", ":lua require('harpoon.ui').nav_file(3)<CR>")
nnoremap("<leader>hi", ":lua require('harpoon.ui').nav_file(4)<CR>")

nnoremap("<leader>tn", ":lua require('harpoon.term').gotoTerminal(1)<CR>")
nnoremap("<leader>te", ":lua require('harpoon.term').gotoTerminal(2)<CR>")

-- fugitive
nnoremap("<leader>gs", ":Git<CR>", silent)

-- Todo Comment
nnoremap("<leader>ft", ":TodoTelescope<CR>", silent)

-- Hop
nnoremap("<leader><leader>b", ":HopWordBC<CR>")
nnoremap("<leader><leader>w", ":HopWordAC<CR>")

-- undotree
nnoremap("<leader>u", ":UndotreeShow<CR>", silent)

-- treesitter-unit
utils.xnoremap("iu", ":lua require('treesitter-unit').select()<CR>")
utils.xnoremap("au", ":lua require('treesitter-unit').select(true)<CR>")
utils.onoremap("iu", ":<C-u>lua require('treesitter-unit').select()<CR>")
utils.onoremap("au", ":<C-u>lua require('treesitter-unit').select(true)<CR>")

-- symbols
nnoremap("<leader>so", ":SymbolsOutline<CR>", silent)

-- luasnips
vim.cmd([[
  imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>'
  inoremap <silent> <C-j> <Cmd>lua require('luasnip').jump(-1)<CR>
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
  snoremap <silent> <C-k> <Cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <C-j> <Cmd>lua require('luasnip').jump(-1)<CR>
]])

-- gomove
utils.imap("<A-h>", "<Esc>:lua require('gomove.mappings.base').MoveLineHorizontal(-vim.v.count1)<CR>i")
utils.imap("<A-j>", "<Esc>:lua require('gomove.mappings.base').MoveLineVertical(vim.v.count1)<CR>i")
utils.imap("<A-k>", "<Esc>:lua require('gomove.mappings.base').MoveLineVertical(-vim.v.count1)<CR>i")
utils.imap("<A-l>", "<Esc>:lua require('gomove.mappings.base').MoveLineHorizontal(vim.v.count1)<CR>i")
