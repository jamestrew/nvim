local utils = require("utils")
local lspsettings = require("lsp.settings")
local nnoremap = utils.nnoremap
local l = require("mappings").l

local function on_attach(client, bufnr)
  local opts = { silent = true, buffer = bufnr }
  nnoremap("gD", vim.lsp.buf.declaration, opts)
  nnoremap("K", vim.lsp.buf.hover, opts)
  nnoremap("<C-k>", vim.lsp.buf.signature_help, opts)
  nnoremap(l("D"), vim.lsp.buf.type_definition, opts)
  nnoremap(l("rn"), vim.lsp.buf.rename, opts)
  nnoremap(l("od"), vim.diagnostic.open_float, opts)
  nnoremap(l("ca"), vim.lsp.buf.code_action, opts)
  nnoremap(l("fm"), function() vim.lsp.buf.format({ async = true }) end, opts)

  -- Lsp Tele
  nnoremap("gd", require("jtelescope").lsp_definition, opts)
  nnoremap(l("gdv"), function()
    vim.cmd.vsplit()
    require("jtelescope").lsp_definition()
  end, opts)
  nnoremap(l("gds"), function()
    vim.cmd.split()
    require("jtelescope").lsp_definition()
  end, opts)
  nnoremap("gr", require("jtelescope").lsp_reference, opts)
  nnoremap(l("gi"), ":Telescope lsp_implementations<CR>", opts)
  nnoremap(l("fs"), require("jtelescope").get_symbols, opts)
  nnoremap(l("td"), ":Telescope diagnostics bufnr=0<CR>", opts)
  nnoremap(l("tw"), ":Telescope diagnostics<CR>", opts)

  local _on_attach = lspsettings._on_attach[client.name]
  if _on_attach then _on_attach(client, bufnr) end
  if client.server_capabilities.documentHighlightProvider then require("autocmds").lsp(bufnr) end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp = function()
  local lspconfig = require("lspconfig")
  for _, server in ipairs(Work and lspsettings.work_server_list or lspsettings.server_list) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    opts = vim.tbl_deep_extend("keep", opts, lspsettings[server] or {})
    lspconfig[server].setup(opts)
  end

  -- replace the default lsp diagnostic letters with prettier symbols
  vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

  vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

  -- require("lspconfig.configs").monkeyls = {
  --   default_config = {
  --     cmd = { "/home/jt/go/bin/golsp", "--logs", "/tmp/golsp.log" },
  --     filetypes = { "mon" },
  --     single_file_support = true,
  --     root_dir = lspconfig.util.root_pattern("test"),
  --   },
  -- }

  -- lspconfig.monkeyls.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  -- })
end

local null_ls = function()
  local null_ls = require("null-ls")
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
    },
    on_attach = on_attach,
  })
end

return {
  { "williamboman/mason.nvim", config = true },
  { "neovim/nvim-lspconfig", config = lsp },
  { "jose-elias-alvarez/null-ls.nvim", config = null_ls },
  { "folke/neodev.nvim", config = true },
  { "b0o/SchemaStore.nvim" },
  {
    "simrat39/symbols-outline.nvim",
    opts = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = false,
      auto_close = false,
      autofold_depth = 1,
      position = "left",
      relative_width = false,
      width = 40,
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = false,
      preview_bg_highlight = "Pmenu",
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
      },
      lsp_blacklist = {},
      symbol_blacklist = {},
      symbols = {
        File = { icon = "", hl = "TSURI" },
        Module = { icon = "", hl = "TSNamespace" },
        Namespace = { icon = "", hl = "TSNamespace" },
        Package = { icon = "", hl = "TSNamespace" },
        Class = { icon = "𝓒", hl = "TSType" },
        Method = { icon = "ƒ", hl = "TSMethod" },
        Property = { icon = "", hl = "TSMethod" },
        Field = { icon = "", hl = "TSField" },
        Constructor = { icon = "", hl = "TSConstructor" },
        Enum = { icon = "ℰ", hl = "TSType" },
        Interface = { icon = "ﰮ", hl = "TSType" },
        Function = { icon = "", hl = "TSFunction" },
        Variable = { icon = "", hl = "TSConstant" },
        Constant = { icon = "", hl = "TSConstant" },
        String = { icon = "𝓐", hl = "TSString" },
        Number = { icon = "#", hl = "TSNumber" },
        Boolean = { icon = "⊨", hl = "TSBoolean" },
        Array = { icon = "", hl = "TSConstant" },
        Object = { icon = "⦿", hl = "TSType" },
        Key = { icon = "🔐", hl = "TSType" },
        Null = { icon = "NULL", hl = "TSType" },
        EnumMember = { icon = "", hl = "TSField" },
        Struct = { icon = "𝓢", hl = "TSType" },
        Event = { icon = "🗲", hl = "TSType" },
        Operator = { icon = "+", hl = "TSOperator" },
        TypeParameter = { icon = "𝙏", hl = "TSParameter" },
      },
    },
  },
}
