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
        -- disable = { "assign-type-mismatch", "doc-field-no-class" },
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

M.clangd = {
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
}

M["rust_analyzer"] = {
  settings = {
    ["rust-analyzer"] = {
      completion = {
        callable = { snippets = "fill_arguments" },
        fullFunctionSignatures = { enable = true },
      },
      procMacro = { enable = true },
      check = {
        command = "clippy",
      },
      cargo = {
        features = "all",
      },
    },
  },
}

M.ts_ls = {
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
  settings = {
    implicitProjectConfiguration = {
      checkJs = true,
    },
  },
}

M.basedpyright = {
  settings = {
    basedpyright = {
      typeCheckingMode = "standard",
    },
  },
}

M.nil_ls = {
  settings = {
    ["nil"] = {
      formatting = { command = { "nixfmt" } },
    },
  },
}

M.bashls = {
  filetypes = { "bash", "sh", "zsh" },
}

M.server_list = {
  "cssls",
  -- "sqls",
  -- "pyright",
  "basedpyright",
  "ruff",
  "eslint",
  "emmet_language_server",
  "html",
  "lua_ls",
  "jsonls",
  "gopls",
  "bashls",
  -- "ts_ls",
  "biome",
  "clangd",
  "taplo", -- toml
  -- "rust_analyzer",
  -- "denols",
  "nil_ls",

  -- "ts_query_ls"
  "tailwindcss",
}

return M
