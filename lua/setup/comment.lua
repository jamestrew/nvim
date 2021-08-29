local M = {}

M.config = function()
  local comment = require("nvim_comment")

  comment.setup({
    hook = function()
      if vim.api.nvim_buf_get_option(0, "filetype") == "typescriptreact" then
        require("ts_context_commentstring.internal").update_commentstring()
      end
    end,
  })
end

return M
