vim.api.nvim_create_user_command("PRView", function()
  local text = vim.fn.expand("<cword>")
  if not text:match("^%d+$") then error(string.format("need number, got %s", text)) end

  vim.system({ "gh", "pr", "view", text, "--web" })
end, {})
