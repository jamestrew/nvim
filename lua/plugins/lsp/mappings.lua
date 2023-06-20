local jtelescope = require("plugins.telescope.pickers")

return function(bufnr)
  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>od", vim.diagnostic.open_float, opts)
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, opts)

  vim.keymap.set({ "i", "n" }, "<C-i>", function() vim.lsp.buf.inlay_hint(bufnr) end, opts)

  -- Lsp Tele
  vim.keymap.set("n", "gd", jtelescope.lsp_definition, opts)
  vim.keymap.set(
    "n",
    "<leader>gdv",
    function() jtelescope.lsp_definition({ jump_type = "vsplit" }) end,
    opts
  )
  vim.keymap.set(
    "n",
    "<leader>gds",
    function() jtelescope.lsp_definition({ jump_type = "split" }) end,
    opts
  )
  vim.keymap.set("n", "gr", jtelescope.lsp_reference, opts)
  vim.keymap.set("n", "<leader>gi", ":Telescope lsp_implementations<CR>", opts)
  vim.keymap.set("n", "<leader>fs", jtelescope.get_symbols, opts)
  vim.keymap.set("n", "<leader>td", ":Telescope diagnostics bufnr=0<CR>", opts)
  vim.keymap.set("n", "<leader>tw", ":Telescope diagnostics<CR>", opts)
end
