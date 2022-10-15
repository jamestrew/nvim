local import = require("utils").import

local setup = {
  commands = {
    Norm = { cmd = "norm" },
    S = { cmd = "g" },
    Reg = {
      cmd = "norm",
      args = function(opts) return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args end,
      range = "",
    },
  },
}

import("live-command", setup)
