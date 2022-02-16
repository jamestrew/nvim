local has_harpoon, harpoon = pcall(require, "harpoon")
if has_harpoon then
  require("harpoon.utils").branch_key = function()
    local branch = require("galaxyline.providers.vcs").get_git_branch()
    if branch then
        return vim.loop.cwd() .. "-" .. branch
    else
        return vim.loop.cwd()
    end
  end

  harpoon.setup({
    global_settings = {
      save_on_toggle = true,
      save_on_change = true,
      mark_branch = true,
    },
  })
end
