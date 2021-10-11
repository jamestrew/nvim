local M = {}

M.config = function()
  local worktree = require("git-worktree")
  local harpoon = require("harpoon")

  worktree.on_tree_change(function(op, _, _)
    if op == worktree.Operations.Switch then
      harpoon.mark.clear_all()
      harpoon.term.clear_all()
    end
  end)
end

return M
