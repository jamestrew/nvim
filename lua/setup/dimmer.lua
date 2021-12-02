local M = {}

M.config = function()
  local dimmer = require("dimmer")
  dimmer.setup({
    opacity = 10,
    ft_ignore = { "netrw", "Outline", "undotree" },
    log_level = "trace",
    debug = true,
  })
end

M.list_windows = function()
  local ret = {}
  for _, win_data in pairs(vim.fn.getwininfo()) do
    table.insert(ret, win_data.winid)
  end
  return ret
end

return M
