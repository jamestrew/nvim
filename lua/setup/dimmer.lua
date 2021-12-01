local M = {}

M.config = function()
  local utils = require("utils")

  local dimmer = require("dimmer")
  dimmer.setup({
    opacity = 85,
    ft_ignore = { "netrw", "Outline", "undotree" },
    log_level = "trace",
    debug = true,
  })

  utils.nnoremap("<leader><leader>d", ":DimmerToggle<CR>")
  utils.nnoremap("<leader>od", ":lua require('dimmer').get_state().overlays<CR>")
end

return M
