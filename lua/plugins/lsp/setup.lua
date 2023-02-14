local lspsettings = require("plugins.lsp.settings")
local lspconfig = require("lspconfig")

local function on_attach(client, bufnr)
  require("plugins.lsp.mappings")(bufnr)
  local _on_attach = lspsettings._on_attach[client.name]
  if _on_attach then _on_attach(client, bufnr) end
  if client.server_capabilities.documentHighlightProvider then require("autocmds").lsp(bufnr) end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

return function()
  for _, server in ipairs(lspsettings.server_list) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    opts = vim.tbl_deep_extend("keep", opts, lspsettings[server] or {})
    lspconfig[server].setup(opts)
  end

  -- require("lspconfig.configs").monkeyls = {
  --   default_config = {
  --     cmd = { "/home/jt/go/bin/golsp", "--logs", "/tmp/golsp.log" },
  --     filetypes = { "mon" },
  --     single_file_support = true,
  --     root_dir = lspconfig.util.root_pattern("test"),
  --   },
  -- }
  --
  -- lspconfig.monkeyls.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  -- })
end
