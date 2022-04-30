local installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")

if not installer_ok and not lspconfig_ok then
  vim.notify("nvim-lsp-installer and nvim-lspconfig not installed", vim.log.levels.WARN)
end

local lspsettings = require("lsp.settings")

lsp_installer.setup({})


local function on_attach(client, bufnr)
  require("mappings").lsp(bufnr)
  require("autocmds").lsp(bufnr)

  if client.name == "typescript" then
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({ lspsettings.ts_utils_setup })
    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.offsetEncoding = { "utf-16" }

local servers = {
  "jsonls",
  "gopls",
  -- "graphql",
  "bashls",
  "tsserver",
  "sumneko_lua",
  "clangd",
  "vimls",
  "eslint",
  "cssls",
  "sqls",
  "html",
  "pyright",
  -- "tailwindcss",
}

for _, server in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = lspsettings[server],
  }
  if server == "sumneko_lua" then
    opts = require("lua-dev").setup({
      lspconfig = opts,
    })
  end
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
