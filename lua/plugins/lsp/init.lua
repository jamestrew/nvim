local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "SmiteshP/nvim-navic" },
    { "williamboman/mason.nvim", config = true },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "folke/neodev.nvim", config = true },
    { "b0o/SchemaStore.nvim" },
    { "simrat39/rust-tools.nvim" },
    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        local lsp_lines = require("lsp_lines")
        lsp_lines.setup()
        lsp_lines.toggle()
        vim.keymap.set("n", "<leader><leader>od", function()
          local virt_lines = lsp_lines.toggle()
          vim.diagnostic.config({ virtual_text = not virt_lines })
        end)
      end,
    },
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
    },
  },
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  local lspsettings = require("plugins.lsp.settings")
  local lspconfig = require("lspconfig")

  vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
  local function on_attach(client, bufnr)
    -- client.server_capabilities.semanticTokensProvider = nil
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end

    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
        group = "lsp_augroup",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
        group = "lsp_augroup",
      })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args) vim.bo[args.buf].formatexpr = nil end,
      group = "lsp_augroup",
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function() vim.lsp.buf.format() end,
      group = "lsp_augroup",
    })
    require("plugins.lsp.mappings")(bufnr)
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- replace the default lsp diagnostic letters with prettier symbols
  vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

  vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

  for _, server in ipairs(lspsettings.server_list) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    opts = vim.tbl_deep_extend("keep", opts, lspsettings[server] or {})
    lspconfig[server].setup(opts)
  end

  require("rust-tools").setup({
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
  })

  -- require("lspconfig.configs").monkeyls = {
  --   default_config = {
  --     cmd = { "/home/jt/go/bin/golsp", "--logs", "/tmp/golsp.log" },
  --     filetypes = { "mon" },
  --     single_file_support = true,
  --     root_dir = lspconfig.util.root_pattern("test"),
  --   },
  -- }
  --
  -- lspconfig.monkeyls.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  -- })

  -- null_ls
  local _, null_ls = pcall(require, "null-ls")
  null_ls.setup({
    sources = {
      debug = true,
      -- formatting
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.golines,

      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.sqlfluff.with({
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
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
