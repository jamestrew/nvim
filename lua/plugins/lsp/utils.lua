local function toggle_inlay_hints()
  if vim.lsp.inlay_hint.is_enabled() then
    vim.lsp.inlay_hint.enable(false)
  else
    vim.lsp.inlay_hint.enable()
  end
end

local function attach_mappings(bufnr)
  local jtelescope = require("plugins.telescope.pickers")

  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set({ "n", "i" }, "<C-f>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>od", vim.diagnostic.open_float, opts)
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, opts)

  vim.keymap.set({ "i", "n" }, "<C-h>", toggle_inlay_hints, opts)

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
  vim.keymap.set("n", "<leader><leader>fs", jtelescope.lsp_document_symbols, opts)
  vim.keymap.set("n", "<leader>td", ":Telescope diagnostics bufnr=0<CR>", opts)
  vim.keymap.set("n", "<leader>tw", ":Telescope diagnostics<CR>", opts)
end

local function on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args) vim.bo[args.buf].formatexpr = nil end,
    group = "lsp_augroup",
  })

  attach_mappings(bufnr)
end

return {
  attach_mappings = attach_mappings,
  on_attach = on_attach,
}
