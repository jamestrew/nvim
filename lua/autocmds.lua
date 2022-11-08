local M = {}

local my_augroup = vim.api.nvim_create_augroup("my_augroup", { clear = true })

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "lspinfo", "fugitive", "qf" },
  command = "nnoremap <buffer><silent> q :quit<CR>",
  group = my_augroup,
})

-- get rid of weird formatoptions
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "setlocal formatoptions-=r formatoptions-=o",
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

vim.api.nvim_create_autocmd("User", {
  pattern = "PackerComplete",
  callback = require("utils").plugin_urls,
  group = my_augroup,
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

vim.api.nvim_create_augroup("dadbod", { clear = true })
M.dadbod = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
      require("cmp").setup.buffer({
        sources = {
          { name = "vim-dadbod-completion" },
        },
      })
    end,
    group = "dadbod",
  })
end

return M
