local import = require("utils").import

local opts = {
  tint = -40,
  tint_background_colors = false,
  highlight_ignore_pattern = { "WinSeparator", "Telescope*" },
  window_ignore_function = function(winid)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
    local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
    -- Do not tint `terminal` or floating windows, tint everything else
    return buftype == "terminal" or floating
  end,
}

import("tint", opts)
