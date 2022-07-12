local ok, luasnip = pcall(require, "luasnip")

if not ok then vim.notify("luasnip not installed", vim.log.levels.WARN) end

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
end)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if luasnip.jumpable(-1) then luasnip.jump(-1) end
end)

vim.keymap.set("i", "<C-l>", function()
  if luasnip.choice_active() then luasnip.change_choice(1) end
end)
