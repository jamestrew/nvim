local ok, null_ls = pcall(require, "null-ls")

if not ok then
  vim.notify("null_ls not installed", vim.log.levels.WARN)
  return
end

local function on_attach(_, bufnr) require("mappings").lsp(bufnr) end

null_ls.setup({
  sources = {
    debug = true,
    -- formatting
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.sql_formatter,
    null_ls.builtins.formatting.sqlfluff.with({
      extra_args = { "--dialect", "postgres" }, -- change to your dialect
    }),

    -- diagnostic
    -- null_ls.builtins.diagnostics.luacheck, too much
    null_ls.builtins.diagnostics.zsh,

    -- code_actions
    -- null_ls.builtins.code_actions.gitsigns,
  },
  on_attach = on_attach,
})
