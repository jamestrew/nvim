local jtelescope = require("plugins.telescope.pickers")
local illuminate = require("illuminate")

local function toggle_inlay_hints()
  if vim.lsp.inlay_hint.is_enabled() then
    vim.lsp.inlay_hint.enable(0, false)
  else
    vim.lsp.inlay_hint.enable()
  end
end

---@param key string
---@param direction "next"|"prev"
---@param bufnr number
local function illuminate_goto(key, direction, bufnr)
  vim.keymap.set(
    "n",
    key,
    function() illuminate["goto_" .. direction .. "_references"](false) end,
    { silent = true, buffer = bufnr }
  )
end

---@param key string
---@param direction "next"|"prev"
---@param severity DiagnosticSeverity?
---@param bufnr number
local function diagnostic_goto(key, direction, severity, bufnr)
  local go = direction == "next" and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity or nil
  vim.keymap.set(
    "n",
    key,
    function() go({ severity = severity }) end,
    { silent = true, buffer = bufnr }
  )
end

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

  illuminate_goto("]r", "next", bufnr)
  illuminate_goto("[r", "prev", bufnr)

  diagnostic_goto("]d", "next", nil, bufnr)
  diagnostic_goto("[d", "prev", nil, bufnr)
  diagnostic_goto("]e", "next", vim.diagnostic.severity.ERROR, bufnr)
  diagnostic_goto("[e", "prev", vim.diagnostic.severity.ERROR, bufnr)
  diagnostic_goto("]w", "next", vim.diagnostic.severity.WARN, bufnr)
  diagnostic_goto("[w", "prev", vim.diagnostic.severity.WARN, bufnr)
end
