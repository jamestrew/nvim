local function inlay_hints_toggle() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end

local function diag_toggle_virt_text()
  local virt_text = vim.diagnostic.config().virtual_text or false
  vim.diagnostic.config({ virtual_text = not virt_text })
end

local function diag_toggle_virt_lines()
  local virt_lines = vim.diagnostic.config().virtual_lines or false
  vim.diagnostic.config({ virtual_lines = not virt_lines })
end

local function attach_mappings(bufnr)
  local pickers = require("plugins.snacks.pickers")

  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>od", diag_toggle_virt_text, opts)
  vim.keymap.set("n", "<leader><leader>od", diag_toggle_virt_lines, opts)
  vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set({ "i", "n" }, "<C-h>", inlay_hints_toggle, opts)

  -- Lsp Tele
  vim.keymap.set("n", "gd", pickers.lsp_definitions, opts)
  vim.keymap.set("n", "grr", pickers.lsp_references, opts)
  vim.keymap.set("n", "gri", Snacks.picker.lsp_implementations, opts)
  vim.keymap.set("n", "gO", pickers.lsp_document_symbols, opts)
  vim.keymap.set("n", "<leader>td", Snacks.picker.diagnostics_buffer, opts)
  vim.keymap.set("n", "<leader>tw", Snacks.picker.diagnostics, opts)
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
