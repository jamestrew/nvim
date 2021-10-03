local M = {}

M.config = function()
  local neogit = require("neogit")

  neogit.setup({
    disable_insert_on_commit = true,
    disable_commit_confirmation = true,
    commit_popup = {
      kind = "split",
    },
  })
end

return M
