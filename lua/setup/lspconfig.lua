local M = {}

M.config = function()
  local lspsettings = require("setup.lsp.settings")

  local function on_attach(client, bufnr)
    require("lsp_signature").on_attach(lspsettings.sig)
    require("illuminate").on_attach(client)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.name == "typescript" then
      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup({ lspsettings.ts_utils_setup })
      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = lspsettings[server.name],
    }
    if server.name == "sumneko_lua" then
      opts = require("lua-dev").setup({
        lspconfig = opts,
      })
    end
    server:setup(opts)
    vim.cmd([[ do User LspAttachBuffers ]])
  end)

  require("lspconfig").perlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- replace the default lsp diagnostic letters with prettier symbols
  vim.fn.sign_define("LspDiagnosticsSignError", { text = "", numhl = "LspDiagnosticsDefaultError" })
  vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "LspDiagnosticsDefaultWarning" })
  vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "LspDiagnosticsDefaultInformation" })
  vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", numhl = "LspDiagnosticsDefaultHint" })

  vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])
end

return M
