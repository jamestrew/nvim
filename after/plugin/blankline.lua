local ok, indent = pcall(require, "indent_blankline")

if not ok then
  return
end

vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = "▏"

vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
vim.g.indent_blankline_buftype_exclude = { "terminal" }

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false

indent.setup({
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
})
