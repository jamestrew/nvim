vim.api.nvim_create_augroup("my_config", { clear = true })

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "lspinfo", "fugitive", "qf" },
  command = "nnoremap <buffer><silent> q :quit<CR>",
  group = "my_config",
})

-- get rid of weird formatoptions
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "setlocal formatoptions-=r formatoptions-=o",
  group = "my_config",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank()",
  group = "my_config",
})

-- autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
  group = "my_config",
})

-- TODO: is User autocmds doable with lua?
vim.cmd([[
  autocmd User PackerComplete lua require'utils'.plugin_urls()
]])
