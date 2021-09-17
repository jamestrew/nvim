local utils = require("utils")
local silent = { silent = true }
local sexpr = { silent = true, expr = true }

-- move line(s) up/down
utils.nnoremap("<A-j>", ":m .+1<CR>==", silent)
utils.nnoremap("<A-k>", ":m .-2<CR>==", silent)
utils.imap("<A-j>", "<Esc>:m .+1<CR>==i")
utils.imap("<A-k>", "<Esc>:m .-2<CR>==i")
utils.vnoremap("<A-j>", ":m '>+1<CR>gv=gv", silent)
utils.vnoremap("<A-k>", ":m '<-2<CR>gv=gv", silent)

-- paste/delete and keep register clean
utils.vnoremap("<leader>p", '"_dP')
utils.vnoremap("<leader>d", '"_d')

-- better indenting
utils.vnoremap("<", "<gv", silent)
utils.vnoremap(">", ">gv", silent)

-- easier exit insert mode in the terminal
utils.tnoremap("<Esc>", "<C-\\><C-n>")

-- endofline behavior for Y like D, C
utils.nnoremap("Y", "y$")

-- keeps jumps centered
utils.nnoremap("n", "nzzzv")
utils.nnoremap("N", "Nzzzv")
utils.nnoremap("<leader>J", "mzJ`z")

------------------------                  -------------------------
------------------------ Plugin Specifics -------------------------
------------------------                  -------------------------

-- Commenter Keybinding
utils.nnoremap("<leader>/", ":CommentToggle<CR>", silent)
utils.vnoremap("<leader>/", ":CommentToggle<CR>", silent)

-- nvim tree
-- utils.nnoremap("<C-n>", ":NvimTreeToggle<CR>", silent)

-- format code
utils.nnoremap("<Leader>fm", ":Neoformat<CR>", silent)

-- Telescope
utils.nnoremap("<C-p>", ":lua require('setup.telescope').find_files()<CR>")
utils.nnoremap("<C-e>", ":lua require('setup.telescope').find_dir()<CR>", silent)
utils.nnoremap("<leader>fw", ":Telescope live_grep<CR>", silent)
utils.nnoremap("<leader>gc", ":Telescope git_commits<CR>", silent)
utils.nnoremap("<leader>fb", ":Telescope buffers<CR>", silent)
utils.nnoremap("<leader>fh", ":Telescope help_tags<CR>", silent)
utils.nnoremap("<leader>fo", ":Telescope oldfiles<CR>", silent)
utils.nnoremap("<leader>rc", ":lua require'setup.telescope'.search_dotfiles()<CR>", silent)
utils.nnoremap("<leader>fg", ":lua require'setup.telescope'.git_worktrees()<CR>", silent)
utils.nnoremap("<leader>ct", ":lua require'setup.telescope'.create_git_worktree()<CR>", silent)
utils.nnoremap("<leader>fp", ":lua require'setup.telescope'.projects()<CR>", silent)
utils.nnoremap("<leader>fy", ":lua require'setup.telescope'.neoclip()<CR>", silent)
utils.nnoremap("<leader>fc", ":lua require'telescope'.commands()<CR>", silent)

-- Lsp
utils.nnoremap("gD", ":lua vim.lsp.buf.declaration()<CR>", silent)
utils.nnoremap("K", ":lua vim.lsp.buf.hover()<CR>", silent)
utils.nnoremap("<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", silent)
utils.nnoremap("<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", silent)
utils.nnoremap("<leader>rn", ":lua vim.lsp.buf.rename()<CR>", silent)
utils.nnoremap("<leader>d", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", silent)
-- Lsp Tele
utils.nnoremap("gd", ":Telescope lsp_definitions<CR>", silent)
utils.nnoremap("gr", ":Telescope lsp_references<CR>", silent)
utils.nnoremap("<leader>ca", ":lua require('setup.telescope').lsp_code_actions()<CR>", silent)
utils.nnoremap("<leader>gi", ":Telescope lsp_implementations<CR>", silent)
utils.nnoremap("<leader>fs", ":lua require('setup.telescope').get_symbols()<CR>", silent)
utils.nnoremap("<leader>tw", ":Telescope lsp_workspace_diagnostics<CR>", silent)
utils.nnoremap("<leader>td", ":Telescope lsp_document_diagnostics<CR>", silent)

-- Refactoring
utils.nnoremap("<leader>rt", ":norm! V<CR> :lua require'setup.telescope'.refactor()<CR>", silent)
utils.vnoremap("<leader>rt", ":lua require'setup.telescope'.refactor()<CR>", silent)

-- Harpoon
utils.nnoremap("<leader>a", ":lua require'harpoon.mark'.add_file()<CR>", silent)
utils.nnoremap("<leader>e", ":lua require'harpoon.ui'.toggle_quick_menu()<CR>", silent)

utils.nnoremap("<leader>hn", ":lua require('harpoon.ui').nav_file(1)<CR>")
utils.nnoremap("<leader>he", ":lua require('harpoon.ui').nav_file(2)<CR>")
utils.nnoremap("<leader>ho", ":lua require('harpoon.ui').nav_file(3)<CR>")
utils.nnoremap("<leader>hi", ":lua require('harpoon.ui').nav_file(4)<CR>")

utils.nnoremap("<leader>tn", ":lua require('harpoon.term').gotoTerminal(1)<CR>")
utils.nnoremap("<leader>te", ":lua require('harpoon.term').gotoTerminal(2)<CR>")

-- neogit
utils.nnoremap("<leader>gs", ":lua require('neogit').open({ kind = 'split' })<CR>")

-- Todo Comment
utils.nnoremap("<leader>ft", ":TodoTelescope<CR>", silent)

-- Hop
utils.nnoremap("<leader><leader>f", ":HopWord<CR>")

-- undotree
utils.nnoremap("<leader>u", ":UndotreeShow<CR>", silent)

-- treesitter-unit
utils.xnoremap("iu", ":lua require('treesitter-unit').select()<CR>")
utils.xnoremap("ia", ":lua require('treesitter-unit').select(true)<CR>")
utils.onoremap("iu", ":<C-u>lua require('treesitter-unit').select()<CR>")
utils.onoremap("ia", ":<C-u>lua require('treesitter-unit').select(true)<CR>")
