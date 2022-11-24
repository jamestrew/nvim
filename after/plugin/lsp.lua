local import = require("utils").import
local lspsettings = require("lsp.settings")

local lspconfig = import("lspconfig")
local navic = import("nvim-navic")
import("neodev", {})

if vim.tbl_contains({ lspconfig, navic }, nil) then return end

local function on_attach(client, bufnr)
  require("mappings").lsp(bufnr)
  if not vim.tbl_contains(lspsettings.navic_ignore, client.name) then
    navic.attach(client, bufnr)
  end
  if client.server_capabilities.documentHighlightProvider then require("autocmds").lsp(bufnr) end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(Work and lspsettings.work_server_list or lspsettings.server_list) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  opts = vim.tbl_deep_extend("keep", opts, lspsettings[server] or {})
  lspconfig[server].setup(opts)
end

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

require 'lspconfig.configs'.monkeyls = {
  default_config = {
    cmd = { "/home/jt/go/bin/golsp-sdk", "--logs", "/tmp/golsp.log"},
    filetypes = { "mon" },
    single_file_support = true,
    root_dir = lspconfig.util.root_pattern("test"),
  },
}

lspconfig.monkeyls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
