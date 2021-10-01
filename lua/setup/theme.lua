local M = {}

M.config = function()
  local github = require("github-theme")
  github.setup({
    theme_style = "dimmed",
    keyword_style = "NONE",
    dark_float = true,
  })
end

return M
