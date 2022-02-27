local ok, null_ls = pcall(require, "null-ls")

if not ok then
  vim.notify("null_ls not installed", vim.log.levels.WARN)
  return
end

null_ls.setup({
  sources = {
    -- formatting
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.clang_format,
    -- TODO: get eslint or eslint_d?
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.stylua,

    -- diagnostic
    -- null_ls.builtins.diagnostics.luacheck, too much
    null_ls.builtins.diagnostics.zsh,

    -- code_actions
    null_ls.builtins.code_actions.gitsigns,
  },
})
