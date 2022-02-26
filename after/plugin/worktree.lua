local has_worktree, worktree = pcall(require, "git-worktree")
local has_harpoon, _ = pcall(require, "harpoon")

if not has_worktree and not has_harpoon then
  return
end

-- local harpmark = require("harpoon.mark")
-- local harpterm = require("harpoon.term")
--
-- worktree.on_tree_change(function(op, _, _)
--   if op == worktree.Operations.Switch then
--     harpmark.clear_all()
--     harpterm.clear_all()
--   end
-- end)
