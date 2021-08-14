local M = {}

M.config = function()
  local ts_config = require "nvim-treesitter.configs"

  ts_config.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = {
      enable = true,
      disable = { "python" },
    },
    autotag = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    context_commentstring = {
      enable = true,
    },
  }
end

return M
