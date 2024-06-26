local utils = require("utils")
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap
local silent = { silent = true }

local leaderkey = "<leader>"
local l = function(after) return string.format("%s%s", leaderkey, after) end

vim.cmd([[nmap <F1> <nop>]])
vim.cmd([[command W :w]])
vim.cmd([[command Q :q]])
vim.cmd([[command Wq :wq]])
vim.cmd([[command Wqa :wqa]])
vim.cmd([[command Qa :qa]])

-- paste/delete and keep register clean
vnoremap(l("p"), '"_dP')
vnoremap(l("d"), '"_d')
nnoremap(l("dd"), '"_d')

-- better indenting
vnoremap("<", "<gv", silent)
vnoremap(">", ">gv", silent)

-- easier exit insert mode in the terminal
utils.tnoremap("<Esc><Esc>", "<C-\\><C-n>")

-- keeps jumps centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap(l("J"), "mzJ`z")

nnoremap(l("pp"), ":echo expand('%:p')<CR>")

-- quick find & replace
nnoremap(l("fr"), ":norm! V<CR> :s/")
vnoremap(l("fr"), ":s/")

nnoremap("<esc>", ":nohl<CR>", silent)

nnoremap("<leader>asht", function()
  print("reloading telescope...")
  R("telescope")
end)

nnoremap(l(l("x")), ":w | so %<CR>", silent)
