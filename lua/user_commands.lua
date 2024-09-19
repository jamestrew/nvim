vim.api.nvim_create_user_command("PRView", function(ev)
  local text
  if #ev.fargs > 0 then
    text = ev.fargs[1]
  else
    text = vim.fn.expand("<cword>")
  end
  if not text:match("^%d+$") then error(string.format("need number, got %s", text)) end

  vim.system({ "gh", "pr", "view", text, "--web" })
end, { nargs = "?" })
