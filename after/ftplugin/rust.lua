vim.opt.formatoptions:remove({ "r", "o" }) -- default "jtcroql"

local rs_group = vim.api.nvim_create_augroup("rs_group", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function() vim.lsp.buf.format() end,
  group = rs_group,
})
