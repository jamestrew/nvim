local M = {}

M.config = function()
  local worktree = require("git-worktree")
  local harpoon = require("harpoon")

  worktree.on_tree_change(function(op, path, upstream)
    os.execute("sleep" .. tonumber(5))
    print("WORKTREE", op, path, upstream)

    if op == worktree.Operations.Switch then
      harpoon.mark.clear_all()
      harpoon.term.clear_all()
    end
  end)
end

return M
