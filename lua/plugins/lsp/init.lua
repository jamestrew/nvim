local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "SmiteshP/nvim-navic" },
    {
      "williamboman/mason.nvim",
      opts = {
        ui = { keymaps = { update_all_packages = "S" } },
      },
      cmd = "Mason",
    },
    { "nvimtools/none-ls.nvim" },
    { "folke/neodev.nvim" },
    { "b0o/SchemaStore.nvim" },
    { "simrat39/rust-tools.nvim" },
    {
      "simrat39/symbols-outline.nvim",
      opts = {
        position = "left",
        relative_width = false,
        width = 40,
        autofold_depth = 1,
        auto_close = true,
      },
      keys = { { "<leader>so", "<cmd>SymbolsOutline<CR>", desc = "symbols-outline" } },
      enabled = false,
    },
    {
      "RRethy/vim-illuminate",
      config = function() require("illuminate").configure({}) end,
    },
  },
  event = { "BufReadPre", "BufNewFile" },
}

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args) vim.bo[args.buf].formatexpr = nil end,
    group = "lsp_augroup",
  })
  require("plugins.lsp.mappings")(bufnr)
end

M.config = function()
  local lspsettings = require("plugins.lsp.settings")
  require("neodev").setup({
    override = function(_, library)
      library.enabled = true
      library.plugins = true
    end,
  })
  local lspconfig = require("lspconfig")

  vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- replace the default lsp diagnostic letters with prettier symbols
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅙",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "󰋼",
        [vim.diagnostic.severity.HINT] = "󰌵",
      }
    }
  })

  vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

  for _, server in ipairs(lspsettings.server_list) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = capabilities,
    }
    opts = vim.tbl_deep_extend("keep", opts, lspsettings[server] or {})
    lspconfig[server].setup(opts)
  end

  -- rust
  local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
  local codelldb_path = extension_path .. "/adapter/codelldb"
  local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

  require("rust-tools").setup({
    tools = {
      inlay_hints = {
        auto = false,
        only_current_line = true,
      },
    },
    server = {
      on_attach = M.on_attach,
      capabilities = capabilities,
      settings = lspsettings["rust_analyzer"].settings,
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  })

  -- null_ls
  local _, null_ls = pcall(require, "null-ls")
  null_ls.setup({
    sources = {
      debug = true,
      -- formatting
      null_ls.builtins.formatting.biome,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.golines,
      -- null_ls.builtins.formatting.sql_formatter,
      null_ls.builtins.formatting.sqlfluff.with({
        extra_args = { "--dialect", "sqlite" }, -- change to your dialect
      }),

      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "sqlite" }, -- change to your dialect
      }),

      -- null_ls.builtins.formatting.sql_formatter,

      -- diagnostic
      -- null_ls.builtins.diagnostics.luacheck, too much
      null_ls.builtins.diagnostics.zsh,

      -- code_actions
      -- null_ls.builtins.code_actions.gitsigns,
    },
    on_attach = function(_, bufnr) require("plugins.lsp.mappings")(bufnr) end,
  })
end

return M
