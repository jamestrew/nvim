local utils = require('utils')
local silent = { silent = true }

-- move line(s) up/down
utils.nnoremap("<A-j>", ":m .+1<CR>==", silent)
utils.nnoremap("<A-k>", ":m .-2<CR>==", silent)
utils.imap("<A-j>", "<Esc>:m .+1<CR>==i")
utils.imap("<A-k>", "<Esc>:m .-2<CR>==i")
utils.vnoremap("<A-j>", ":m '>+1<CR>gv=gv", silent)
utils.vnoremap("<A-k>", ":m '<-2<CR>gv=gv", silent)

-- fancy register yanking and pasting (must have xclip)
utils.vnoremap('<leader>p', '"_dP') -- paste and keep pasted stuff
utils.nnoremap('<leader>y', '"+y')
utils.nnoremap('<leader>Y', 'gg"+yG')
utils.vnoremap('<leader>y', '"+y')

-- better indenting
utils.vnoremap("<", "<gv", silent)
utils.vnoremap(">", ">gv", silent)

utils.tnoremap("<Esc>", "<C-\\><C-n>")

--------------                  ---------------
-------------- Plugin Specifics ---------------
--------------                  ---------------

-- Commenter Keybinding
utils.nnoremap("<leader>/", ":CommentToggle<CR>", silent)
utils.vnoremap("<leader>/", ":CommentToggle<CR>", silent)


--  compe mappings
utils.inoremap("<C-Space>", "compe#complete()", { silent = true, expr = true})
utils.inoremap("<CR>", ":lua require'core.compe'.confirm()<CR>", { silent = true, expr = true})
utils.inoremap("<C-e>", "compe#close()", { silent = true, expr = true})
utils.inoremap("<C-u>", "compe#scroll({ 'delta': -4 })", { silent = true, expr = true})
utils.inoremap("<C-d>", "compe#scroll({ 'delta': +4 })", { silent = true, expr = true})

-- nvim tree
utils.nnoremap("<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- format code
utils.nnoremap("<Leader>fm", [[<Cmd> Neoformat<CR>]], silent)

-- Telescope
if utils.os.is_git_dir == 'O' then
    utils.nnoremap("<C-p>", [[<Cmd> Telescope git_files <CR>]], silent)
else
    utils.nnoremap("<C-p>", [[<Cmd> Telescope find_files <CR>]], silent)
end
utils.nnoremap("<C-e>", [[<Cmd> Telescope file_browser<CR>]], silent)
utils.nnoremap("<leader>fw", [[<Cmd> Telescope live_grep<CR>]], silent)
utils.nnoremap("<leader>gt", [[<Cmd> Telescope git_status<CR>]], silent)

utils.nnoremap("<leader>cm", [[<Cmd> Telescope git_commits<CR>]], silent)
utils.nnoremap("<leader>fb", [[<Cmd>Telescope buffers<CR>]], silent)
utils.nnoremap("<leader>fh", [[<Cmd>Telescope help_tags<CR>]], silent)
utils.nnoremap("<leader>fo", [[<Cmd>Telescope oldfiles<CR>]], silent)
utils.nnoremap("<leader>vrc", ":lua require'core.telescope'.search_dotfiles()<CR>", silent)
utils.nnoremap("<leader>ps", ":lua require'telescope.builtin'.grep_string({ search = vim.fn.input('Grep For > ') })<CR>", silent)


-- Trouble
utils.nnoremap("<leader>tw", "<cmd>Trouble lsp_workspace_diagnostics<CR>", silent)
utils.nnoremap("<leader>td", "<cmd>Trouble lsp_document_diagnostics<CR>", silent)

-- Harpoon
utils.nnoremap("<leader>a", ":lua require'harpoon.mark'.add_file()<CR>", silent)
utils.nnoremap("<leader>e", ":lua require'harpoon.ui'.toggle_quick_menu()<CR>", silent)

utils.nnoremap("<leader>hy", ":lua require('harpoon.ui').nav_file(1)<CR>")
utils.nnoremap("<leader>hn", ":lua require('harpoon.ui').nav_file(2)<CR>")
utils.nnoremap("<leader>he", ":lua require('harpoon.ui').nav_file(3)<CR>")
utils.nnoremap("<leader>ho", ":lua require('harpoon.ui').nav_file(4)<CR>")

utils.nnoremap("<leader>ty", ":lua require('harpoon.term').gotoTerminal(1)<CR>")
utils.nnoremap("<leader>tn", ":lua require('harpoon.term').gotoTerminal(2)<CR>")

-- neogit
utils.nnoremap("<leader>gs", ":lua require('neogit').open()<CR>")
-- utils.nnoremap("<leader>gs", ":G<CR>")
-- utils.nnoremap("<leader>ga", ":Git fetch -all<CR>")
-- utils.nnoremap("<leader>gp", ":Git push<CR>")
-- utils.nnoremap("<leader>gc", ":Git commit<CR>")

-- Todo Comment
utils.nnoremap("<leader>ft", ":TodoTelescope<CR>", silent)

-- Hop
utils.nnoremap("<leader><leader>f", ":HopWord<CR>")
