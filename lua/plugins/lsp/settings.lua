local M = {}

M.lua_ls = {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      format = {
        enable = false,
      },
      hint = {
        enable = true,
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
        library = { vim.env.VIMRUNTIME },
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

M["rust_analyzer"] = {
  settings = {
    ["rust_analyzer"] = {
      checkOnSave = true,
      cargo = {
        features = "all",
      },
    },
  },
}

M.tsserver = {
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
    },
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
  "taplo",
  -- "rust_analyzer",
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
