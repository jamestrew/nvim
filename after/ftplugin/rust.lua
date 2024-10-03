vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = require("plugins.lsp").on_attach,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        checkOnSave = true,
        check = {
          command = "clippy",
        },
        cargo = {
          features = "all",
        },
      },
    },
  },
  -- DAP configuration
  dap = {},
}
