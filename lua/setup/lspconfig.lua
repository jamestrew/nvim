local M = {}

M.config = function()
  local lspconf = require "lspconfig"
  local lspsettings = require "setup.lsp.settings"

  local function on_attach(client, bufnr)
    require("lsp_signature").on_attach() -- lsp signature
    require("illuminate").on_attach(client)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.name == "typescript" then
      local ts_utils = require "nvim-lsp-ts-utils"
      ts_utils.setup { lspsettings.ts_utils_setup }
      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }

  local function setup_servers()
    require("lspinstall").setup()
    local servers = require("lspinstall").installed_servers()

    for _, lang in pairs(servers) do
      if lang == "lua" then
        local luadev = require("lua-dev").setup {
          lspconfig = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = lspsettings.lua,
          },
        }
        lspconf[lang].setup(luadev)
      else
        lspconf[lang].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = vim.loop.cwd,
        }
      end
    end
  end

  setup_servers()

  -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
  require("lspinstall").post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd "bufdo e"
  end

  -- replace the default lsp diagnostic letters with prettier symbols
  vim.fn.sign_define("LspDiagnosticsSignError", { text = "", numhl = "LspDiagnosticsDefaultError" })
  vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "LspDiagnosticsDefaultWarning" })
  vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "LspDiagnosticsDefaultInformation" })
  vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", numhl = "LspDiagnosticsDefaultHint" })

  vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
  vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
  vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]
end

return M
