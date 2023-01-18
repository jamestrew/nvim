local import = require("utils").import

local setup = {
  numhl = true,
  current_line_blame = true,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  sign_priority = 5,
  status_formatter = nil, -- Use default

  on_attach = require("mappings").gitsigns,
}

import("gitsigns", setup)
