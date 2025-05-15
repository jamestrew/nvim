local has_ruff = vim.fn.executable("ruff") == 1

if has_ruff then
  vim.api.nvim_create_user_command(
    "RuffSortImports",
    "!ruff check --fix --select I %",
    {}
  )
end
