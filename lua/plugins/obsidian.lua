local workspace_path = "~/obsidian/personal"

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  cond = function() return vim.fn.getcwd():find(vim.fn.expand(workspace_path), 1, true) == 1 end,
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    sync = { enabled = true },
    workspaces = {
      {
        name = "notes",
        path = workspace_path,
      },
    },
    callbacks = {
      enter_note = function()
        vim.opt_local.conceallevel = 1
        vim.opt_local.wrap = true
        vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
        vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
      end,
    },
    ui = {
      ignore_conceal_warn = true,
    },
  },
}
