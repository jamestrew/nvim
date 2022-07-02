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

M.ts_utils_setup = {
  settings = {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,

    -- import all
    import_all_timeout = 5000, -- ms
    import_all_priorities = {
      buffers = 4, -- loaded buffer names
      buffer_content = 3, -- loaded buffer content
      local_files = 2, -- git files or files with relative path markers
      same_file = 1, -- add to existing import statement
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,

    -- eslint
    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    eslint_bin = "eslint",
    eslint_config_fallback = nil,
    eslint_enable_diagnostics = false,
    eslint_show_rule_id = false,

    -- formatting
    enable_formatting = false,
    formatter = "prettier",
    formatter_config_fallback = nil,

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,

    -- filter diagnostics
    filter_out_diagnostics_by_severity = {},
    filter_out_diagnostics_by_code = {},
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
return M
