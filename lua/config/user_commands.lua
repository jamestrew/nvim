-- TODO: this seems to break with extui and gitsigns previews
vim.api.nvim_create_user_command("GHView", function(ev)
  local text
  if #ev.fargs > 0 then
    text = ev.fargs[1]
  else
    text = vim.fn.expand("<cword>")
  end
  if not text:match("^%d+$") then error(string.format("need number, got %s", text)) end

  local result = vim.system({ "gh", "pr", "view", text, "--web" }):wait()
  if result.code ~= 0 then
    vim.system({ "gh", "issue", "view", text, "--web" })
  end
end, { nargs = "?" })
