local M = {}

M.config = function()
  local worktree = require("git-worktree")
  local harpmark = require("harpoon.mark")
  local harpterm = require("harpoon.term")

  worktree.on_tree_change(function(op, _, _)
    if op == worktree.Operations.Switch then
      harpmark.clear_all()
      harpterm.clear_all()
    end
  end)
end

return M
