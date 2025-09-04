local vi_mode = require("feline.providers.vi_mode")

local providers = require("plugins.feline.providers")
local theme = require("themes.onedark")
local colors = theme.colors

local M = {}

-- [[ active statusline left ]]
M.vi = {
  provider = { name = "vi_mode", opts = { show_mode_name = true, padding = "right" } },
  icon = "",
  hl = function()
    return {
      fg = colors.statusline_bg,
      bg = vi_mode.get_mode_color(),
      style = "bold",
    }
  end,
  left_sep = {
    {
      str = "  ",
      hl = function() return { bg = vi_mode.get_mode_color() } end,
    },
  },
  right_sep = {
    {
      str = "slant_right_2",
      hl = function()
        return {
          fg = vi_mode.get_mode_color(),
          bg = colors.lightbg2,
        }
      end,
    },
  },
}

M.current_dir = {
  provider = providers.current_dir,
  hl = { fg = colors.grey_fg2, bg = colors.lightbg2 },
  right_sep = {
    str = "slant_right_2",
    hl = { fg = colors.lightbg2, bg = colors.statusline_bg },
  },
}

M.git_diffs = {
  add = {
    provider = "git_diff_added",
    icon = " +",
    hl = { fg = colors.base0B, bg = colors.statusline_bg },
  },
  mod = {
    provider = "git_diff_changed",
    icon = " ~",
    hl = { fg = colors.sun, bg = colors.statusline_bg },
  },
  sub = {
    provider = "git_diff_removed",
    icon = " -",
    hl = { fg = colors.red, bg = colors.statusline_bg },
  },
}

M.diagnostics = {
  errors = {
    provider = "diagnostic_errors",
    icon = "  ",
    hl = { fg = colors.red, bg = colors.statusline_bg },
  },
  warns = {
    provider = "diagnostic_warnings",
    icon = "  ",
    hl = { fg = colors.yellow, bg = colors.statusline_bg },
  },
  hints = {
    provider = "diagnostic_hints",
    icon = " 󰋼 ",
    hl = { fg = colors.green, bg = colors.statusline_bg },
  },
  info = {
    provider = "diagnostic_info",
    icon = " 󰌵 ",
    hl = { fg = colors.purple, bg = colors.statusline_bg },
  },
}

M.lsp_client = {
  provider = providers.lsp_client,
  hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
}

-- [[ active statusline mid ]]
M.file_name = {
  provider = providers.file_name_custom,
  hl = { fg = colors.white, bg = colors.statusline_bg },
}

-- [[ active statusline right ]]
M.unsaved = {
  provider = providers.modified_buf_count,
  update = { "BufEnter" },
  hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
  right_sep = {
    str = " ",
    hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
  },
}

M.git_branch = {
  provider = providers.git_branch,
  enabled = function() return vim.g.gitsigns_head or vim.b.gitsigns_head end,
  hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
}

M.my_pos = {
  provider = { name = "position", opts = { padding = true } },
  hl = { fg = colors.statusline_bg, bg = colors.base0B },
  left_sep = {
    {
      str = "slant_right_2",
      hl = { fg = colors.statusline_bg, bg = colors.base0B },
    },
    {
      str = "  ",
      hl = { fg = colors.statusline_bg, bg = colors.base0B },
    },
  },
  right_sep = {
    str = " ",
    hl = { fg = colors.statusline_bg, bg = colors.base0B },
  },
}

return M
