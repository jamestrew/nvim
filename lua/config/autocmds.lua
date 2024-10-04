local my_augroup = vim.api.nvim_create_augroup("my_augroup", { clear = true })

-- show cursor line only in active window
-- NAH: this conflicts with telescope and prolly other plugins
-- vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
--   callback = function()
--     if vim.w.auto_cursorline then
--       vim.wo.cursorline = true
--       vim.w.auto_cursorline = nil
--     end
--   end,
--   group = my_augroup,
-- })
-- vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
--   callback = function()
--     if vim.wo.cursorline then
--       vim.w.auto_cursorline = true
--       vim.wo.cursorline = false
--     end
--   end,
--   group = my_augroup,
-- })

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "lspinfo", "fugitive", "qf" },
  command = "nnoremap <buffer><silent> q :quit<CR>",
  group = my_augroup,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank()",
  group = my_augroup,
})

-- remove whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
  group = my_augroup,
})
