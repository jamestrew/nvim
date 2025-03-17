local silent = { silent = true }

local leaderkey = "<leader>"
local l = function(after) return string.format("%s%s", leaderkey, after) end


-- paste/delete and keep register clean
vim.keymap.set("v", l("p"), '"_dP')
vim.keymap.set("v", l("d"), '"_d')
vim.keymap.set("n", l("dd"), '"_d')

-- better indenting
vim.keymap.set("v", "<", "<gv", silent)
vim.keymap.set("v", ">", ">gv", silent)

-- easier exit insert mode in the terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- keeps jumps centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", l("J"), "mzJ`z")

vim.keymap.set("n", l("pp"), ":echo expand('%:p')<CR>")

-- quick find & replace
vim.keymap.set("n", l("fr"), ":norm! V<CR> :s/")
vim.keymap.set("v", l("fr"), ":s/")

vim.keymap.set("n", "<esc>", ":nohl<CR>", silent)

vim.keymap.set("n", "<leader>asht", function()
  print("reloading telescope...")
  R("telescope")
end)

vim.keymap.set("n", l(l("x")), ":w | so %<CR>", silent)
