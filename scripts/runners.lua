local doit = true

if doit then
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.go",
    callback = function() require("harpoon.tmux").sendCommand("%3", "go test ./...\n") end,
    group = vim.api.nvim_create_augroup("gotesting", { clear = true }),
  })
else
  vim.api.nvim_del_augroup_by_name("gotesting")
end
