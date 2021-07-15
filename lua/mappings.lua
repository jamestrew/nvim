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

--------------                  ---------------
-------------- Plugin Specifics ---------------
--------------                  ---------------

-- Commenter Keybinding
utils.nnoremap("<leader>/", ":CommentToggle<CR>", silent)
utils.vnoremap("<leader>/", ":CommentToggle<CR>", silent)


--  compe mappings
utils.inoremap("<C-Space>", "compe#complete()", { silent = true, expr = true})
utils.inoremap("<CR>", "compe#confirm()", { silent = true, expr = true})
utils.inoremap("<C-e>", "compe#close()", { silent = true, expr = true})

-- nvim tree
utils.nnoremap("<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- format code
utils.nnoremap("<Leader>fm", [[<Cmd> Neoformat<CR>]], silent)

-- Telescope
utils.nnoremap("<Leader>fw", [[<Cmd> Telescope live_grep<CR>]], silent)
utils.nnoremap("<Leader>gt", [[<Cmd> Telescope git_status <CR>]], silent)
utils.nnoremap("<C-p>", [[<Cmd> Telescope git_files <CR>]], silent)
utils.nnoremap("<Leader>cm", [[<Cmd> Telescope git_commits <CR>]], silent)
utils.nnoremap("<Leader>ff", [[<Cmd> Telescope find_files <CR>]], silent)
utils.nnoremap("<Leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], silent)
utils.nnoremap("<Leader>fb", [[<Cmd>Telescope buffers<CR>]], silent)
utils.nnoremap("<Leader>fh", [[<Cmd>Telescope help_tags<CR>]], silent)
utils.nnoremap("<Leader>fo", [[<Cmd>Telescope oldfiles<CR>]], silent)

