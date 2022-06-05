local utils = require("utils")
local has_harpoon, harpoon = pcall(require, "harpoon")

if has_harpoon then
  local branch = utils.get_os_command_output({
    "git",
    "rev-parse",
    "--abbrev-ref",
    "HEAD",
  })[1]

  require("harpoon.utils").branch_key = function()
    if not utils.os.in_bare and branch then
      return vim.loop.cwd() .. "/" .. branch
    else
      return vim.loop.cwd()
    end
  end

  harpoon.setup({
    global_settings = {
      save_on_toggle = true,
      save_on_change = true,
      mark_branch = true,
      excluded_filetypes = { "harpoon", "TelescopePrompt" },
    },
  })
else
  vim.notify("harpoon not loaded", vim.log.levels.WARN)
end
