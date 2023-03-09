local M = {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
  },
  cmd = "SQL",
}

M.init = function()
  vim.api.nvim_create_user_command("SQL", function()
    vim.cmd("tabnew")
    vim.cmd("DBUI")
  end, { desc = "Open Dadbod UI in a new tab" })
end

M.config = function()
  vim.g.db_ui_show_help = 0
  vim.g.db_ui_win_position = "right"
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_winwidth = 50

  vim.api.nvim_create_augroup("dadbod", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
      require("cmp").setup.buffer({
        sources = {
          { name = "vim-dadbod-completion" },
        },
      })
    end,
    group = "dadbod",
  })
end

return M
