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

vim.api.nvim_create_user_command("TIME", function() print(os.date("%a %b %d, %Y %H:%M:%S")) end, {})

vim.api.nvim_create_user_command(
  "DapClearBreakpoints",
  function() require("dap").clear_breakpoints() end,
  { desc = "Clear all DAP breakpoints" }
)

vim.api.nvim_create_user_command("SQL", function()
  vim.cmd("tabnew")
  vim.cmd("DBUI")
end, { desc = "Open Dadbod UI in a new tab" })

vim.api.nvim_create_user_command(
  "DapConditionalBreakpoints",
  function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
  {}
)

vim.api.nvim_create_user_command("NNP", ":NoNeckPain", {})
vim.api.nvim_create_user_command("Mess", ":Messages messages", {})
