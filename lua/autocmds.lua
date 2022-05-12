local M = {}

local my_group = vim.api.nvim_create_augroup("my_group", { clear = true })

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "lspinfo", "fugitive", "qf" },
  command = "nnoremap <buffer><silent> q :quit<CR>",
  group = my_group,
})

-- get rid of weird formatoptions
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "setlocal formatoptions-=r formatoptions-=o",
  group = my_group,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank()",
  group = my_group,
})

-- autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
  group = my_group,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "PackerComplete",
  callback = require("utils").plugin_urls,
  group = my_group,
})

vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
M.lsp = function(bufnr)
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
    group = "lsp_document_highlight",
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
    group = "lsp_document_highlight",
  })
end

return M
