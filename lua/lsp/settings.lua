local M = {}

M.sumneko_lua = {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

M.jsonls = {
  settings = {
    json = {
      -- Schemas https://www.schemastore.org
      schemas = require("schemastore").json.schemas(),
    },
  },
}

M.emmet_ls = {
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
}

M.server_list = {
  "vimls",
  "cssls",
  "sqls",
  "pyright",
  "eslint",
  "emmet_ls",
  "html",
  "sumneko_lua",
  "jsonls",
  "gopls",
  "bashls",
  "tsserver",
  "clangd",
}

M.work_server_list = {
  "cssls",
  "pyright",
  "eslint",
  "emmet_ls",
  "html",
  "sumneko_lua",
  "jsonls",
  "bashls",
  "tsserver",
}

M.navic_ignore = { "eslint", "emmet_ls", "html", "cssls"}

return M
