local ok, luasnip = pcall(require, "luasnip")

if not ok then
  vim.notify("luasnip not installed", vim.log.levels.WARN)
  return
end

luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})

local parse = require("luasnip.util.parser").parse_snippet

luasnip.add_snippets(nil, { -- i dont think this is technically supported?
  all = {
    parse("expand", "--this is what was expanded"),
  },
  lua = {
    parse("lf", "local $1 = function($2)\n  $0\nend"),
  },
})

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
end)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if luasnip.jumpable(-1) then luasnip.jump(-1) end
end)

vim.keymap.set("i", "<C-l>", function()
  if luasnip.choice_active() then luasnip.change_choice(1) end
end)

require("luasnip.loaders.from_vscode").lazy_load()
