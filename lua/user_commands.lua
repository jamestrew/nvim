local gotesting_on = false
vim.api.nvim_create_user_command("GoTesting", function()
  if gotesting_on then
    vim.api.nvim_del_augroup_by_name("gotesting")
    gotesting_on = false
    print("GoTesting disabled")
  else
    local pane = vim.fn.input("Pane #: ")
    pane = "%" .. pane
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.go",
      callback = function() require("harpoon.tmux").sendCommand(pane, "go test ./... -cover\n") end,
      group = vim.api.nvim_create_augroup("gotesting", { clear = true }),
    })
    gotesting_on = true
    print("\nGoTesting enabled")
  end
end, {})

vim.api.nvim_create_user_command("GetHighlight", function()
  vim.cmd([[:echo synIDattr(synID(line("."), col("."), 1), "name")]])
end, {})
