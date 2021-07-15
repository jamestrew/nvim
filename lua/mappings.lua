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

--[[
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <C-e> :lua require('telescope.builtin').file_browser()<CR>
nnoremap <leader>fe :lua require('telescope.builtin').file_browser({cwd = vim.fn.expand("%:p:h"), prompt_title = vim.fn.expand("%:p:h")})<CR>
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>vrc :lua require('theprimeagen.telescope').search_dotfiles()<CR>
]]
