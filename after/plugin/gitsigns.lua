local import = require("utils").import

local setup = {
  signs = {
    add = { hl = "DiffAdd", text = "▌", numhl = "GitSignsAddNr" },
    change = { hl = "DiffChange", text = "▌", numhl = "GitSignsChangeNr" },
    delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
  },
  numhl = true,
  current_line_blame = true,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  sign_priority = 5,
  status_formatter = nil, -- Use default

  on_attach = require("mappings").gitsigns
}

import("gitsigns", setup)
