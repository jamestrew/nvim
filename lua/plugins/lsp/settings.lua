local M = {}

M.lua_ls = {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
        disable = { "assign-type-mismatch", "doc-field-no-class" },
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

M.clangd = {
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
}

M.server_list = {
  "vimls",
  "cssls",
  -- "sqls",
  "pyright",
  "eslint",
  "emmet_ls",
  "html",
  "lua_ls",
  "jsonls",
  "gopls",
  "bashls",
  "tsserver",
  "clangd",
}

local work_server_list = {
  "cssls",
  "pyright",
  "eslint",
  "emmet_ls",
  "html",
  "lua_ns",
  "jsonls",
  "bashls",
  "tsserver",
}

if Work then M.server_list = work_server_list end

return M
