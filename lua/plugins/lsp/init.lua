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
    {
      "simrat39/symbols-outline.nvim",
      opts = {
        position = "left",
        relative_width = false,
        width = 40,
      },
      keys = { "<leader>so", "<cmd>SymbolsOutline<CR>", desc = "symbols-outline" },
    },
  },
}

M.config = function()
  local lspsettings = require("plugins.lsp.settings")
  local lspconfig = require("lspconfig")

  vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
  local function on_attach(client, bufnr)
    local _on_attach = lspsettings._on_attach[client.name]
    if _on_attach then _on_attach(client, bufnr) end

    require("plugins.lsp.mappings")(bufnr)
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
        group = "lsp_document_highlight",
      })

      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
        group = "lsp_document_highlight",
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args) vim.bo[args.buf].formatexpr = nil end,
        group = "lsp_document_highlight",
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function() vim.lsp.buf.format() end,
        group = "lsp_document_highlight",
      })
    end
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
end

return M
