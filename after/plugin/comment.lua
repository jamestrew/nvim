local ok, comment = pcall(require, "Comment")
if not ok then
  vim.notify("Comment.nvim not loaded", vim.log.levels.WARN)
  return
end

comment.setup({
  ---Add a space b/w comment and the line
  ---@type boolean
  padding = true,

  ---Line which should be ignored while comment/uncomment
  ---Example: Use '^$' to ignore empty lines
  ---@type string Lua regex
  ignore = nil,

  ---Whether to create basic (operator-pending) and extra mappings for NORMAL/VISUAL mode
  ---@type table
  mappings = {
    ---operator-pending mapping
    ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
    basic = true,
    ---extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = true,
    ---extended mapping
    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },

  ---LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
  ---@type table
  toggler = {
    ---line-comment toggle
    line = "gcc",
    ---block-comment toggle
    block = "gbc",
  },

  ---LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
  ---@type table
  opleader = {
    ---line-comment opfunc mapping
    line = "gc",
    ---block-comment opfunc mapping
    block = "gb",
  },

  ---Pre-hook, called before commenting the line
  ---@type function|nil
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

  ---Post-hook, called after commenting is done
  ---@type function|nil
  post_hook = nil,
})

local comment_ft = require("Comment.ft")
comment_ft.set("lua", { "--%s", "--[[%s]]" })
