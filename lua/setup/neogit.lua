local M = {}

M.config = function()
  local neogit = require("neogit")

  neogit.setup({
    disable_insert_on_commit = false,
    commit_popup = {
      kind = "split",
    },
  })
end

return M
