
local opt = { noremap = true }

vim.api.nvim_set_keymap("n", "<leader>gs", ":G<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>ga", ":Git fetch -all<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<CR>", opt)
