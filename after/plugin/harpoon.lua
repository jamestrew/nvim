local utils = require("utils")

local has_harpoon, harpoon = pcall(require, "harpoon")
local has_feline, git = pcall(require, "feline.providers.git")

if has_harpoon then
  if has_feline then
    require("harpoon.utils").branch_key = function()
      local branch = git.git_branch()
      if branch then
        return vim.loop.cwd() .. "-" .. branch
      else
        return vim.loop.cwd()
      end
    end
  end

  harpoon.setup({
    global_settings = {
      save_on_toggle = true,
      save_on_change = true,
      mark_branch = not utils.os.in_bare,
    },
  })
else
  vim.notify("harpoon not loaded", vim.log.levels.WARN)
end
