local ok, gl = pcall(require, "galaxyline")
if not ok then
  return
end

local utils = require("utils")
local colors = require("themes." .. vim.g.colors_name).colors
local Path = require("plenary.path")

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 60 then
    return true
  end
  return false
end

local mode_color = function()
  local mode_colors = {
    n = colors.nord_blue,
    i = colors.green,
    c = colors.white,
    V = colors.blue,
    [""] = colors.blue,
    v = colors.blue,
    R = colors.teal,
    s = colors.dark_purple,
  }
  local color = mode_colors[vim.fn.mode()]
  if color == nil then
    color = colors.red
  end
  return color
end

local gls = gl.section
local condition = require("galaxyline.condition")

gl.short_line_list = { "Outline", "undotree" }

local vi_mode_separator1 = {
  ViModeSeparator1 = {
    provider = function()
      vim.cmd("hi GalaxyViModeSeparator1 guifg=" .. mode_color())
      vim.cmd("hi GalaxyViModeSeparator1 guibg=" .. mode_color())
      return "▋"
    end,
    highlight = { colors.nord_blue, colors.statusline_bg },
  },
}

local vi_mode = {
  ViMode = {
    provider = function()
      local alias = {
        n = "Normal",
        i = "Insert",
        c = "Command",
        V = "Visual",
        [""] = "Visual",
        v = "Visual",
        R = "Replace",
        s = "Select",
      }
      local current_mode = alias[vim.fn.mode()]
      vim.cmd("hi GalaxyViMode guibg=" .. mode_color())

      if current_mode == nil then
        print(vim.fn.mode())
        return "  Terminal "
      else
        return "  " .. current_mode .. " "
      end
    end,
    highlight = { colors.statusline_bg, colors.nord_blue },
  },
}

local vi_mode_separator2 = {
  ViModeSeparator2 = {
    provider = function()
      vim.cmd("hi GalaxyViModeSeparator2 guifg=" .. mode_color())
      return "  "
    end,
    highlight = { colors.statusline_bg, colors.lightbg2 },
  },
}

local current_dir = {
  current_dir = {
    provider = function()
      local max_len = 12
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      if #dir_name > max_len then
        dir_name = dir_name:sub(0, max_len) .. "..."
      end
      return "  " .. dir_name .. " "
    end,
    highlight = { colors.grey_fg2, colors.lightbg2 },
    condition = checkwidth,
    separator = " ",
    separator_highlight = { colors.lightbg2, colors.statusline_bg },
  },
}

local diff_add = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = "+",
    highlight = { colors.base0B, colors.statusline_bg },
  },
}

local diff_modified = {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "~",
    highlight = { colors.sun, colors.statusline_bg },
  },
}

local diff_remove = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = "-",
    highlight = { colors.base08, colors.statusline_bg },
  },
}

local diagnostic_error = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = { colors.red, colors.statusline_bg },
  },
}

local diagnostic_warn = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = { colors.yellow, colors.statusline_bg },
  },
}

local diagnostic_info = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    highlight = { colors.green, colors.statusline_bg },
  },
}

local diagnostic_hint = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    highlight = { colors.purple, colors.statusline_bg },
  },
}

local lsp_provider = {
  lsp_status = {
    provider = function()
      local clients = vim.lsp.get_active_clients()
      if #clients == 0 then
        return " No LSP "
      else
        return ""
      end
    end,
    highlight = { colors.grey_fg2, colors.statusline_bg },
    condition = condition.buffer_not_empty,
  },
}

table.insert(gls.left, vi_mode_separator1)
table.insert(gls.left, vi_mode)
table.insert(gls.left, vi_mode_separator2)
table.insert(gls.left, current_dir)
table.insert(gls.left, diff_add)
table.insert(gls.left, diff_modified)
table.insert(gls.left, diff_remove)
table.insert(gls.left, diagnostic_error)
table.insert(gls.left, diagnostic_warn)
table.insert(gls.left, diagnostic_info)
table.insert(gls.left, diagnostic_hint)
table.insert(gls.left, lsp_provider)

-- MIDDLE
local file_icon = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = { colors.white, colors.statusline_bg },
  },
}

local file_name = {
  FileName = {
    provider = function()
      local max_len = checkwidth() and 60 or 35
      local filename = Path:new(vim.fn.expand("%:p")):make_relative(vim.loop.cwd())
      if #filename > max_len then
        filename = Path:new(filename):shorten()
      end
      if vim.bo.modifiable then
        if vim.bo.modified then
          filename = filename .. " " .. ""
        end
      else
        filename = filename .. " " .. ""
      end
      return filename
    end,
    condition = condition.buffer_not_empty,
    highlight = { colors.white, colors.statusline_bg },
  },
}

table.insert(gls.mid, file_icon)
table.insert(gls.mid, file_name)

-- RIGHT SIDE
local unsaved = {
  unsaved = {
    provider = function()
      local unsaved_cnt = utils.modified_buf_count()
      if unsaved_cnt > 0 then
        return "λ" .. unsaved_cnt
      end
    end,
    event = "BufEnter",
    highlight = { colors.grey_fg2, colors.statusline_bg },
  },
}

local git_icon = {
  GitIcon = {
    provider = function()
      return " "
    end,
    condition = require("galaxyline.condition").check_git_workspace,
    highlight = { colors.grey_fg2, colors.statusline_bg },
    separator = " ",
    separator_highlight = { colors.statusline_bg, colors.statusline_bg },
  },
}

local git_branch = {
  GitBranch = {
    provider = function()
      local max_len = 25
      local branch = require("galaxyline.providers.vcs").get_git_branch()
      if #branch > max_len then
        branch = branch:sub(1, max_len) .. ".."
      end
      return branch .. " "
    end,
    condition = function()
      return require("galaxyline.condition").check_git_workspace() and checkwidth()
    end,
    highlight = { colors.grey_fg2, colors.statusline_bg },
  },
}

local line_percentage_sep = {
  some_icon = {
    provider = function()
      return ""
    end,
    separator_highlight = { colors.base0B, colors.lightbg },
    highlight = { colors.statusline_bg, colors.base0B },
  },
}

local line_percentage = {
  line_percentage = {
    provider = function()
      local current_line = vim.fn.line(".")
      local total_line = vim.fn.line("$")
      local current_col = vim.fn.virtcol(".")
      local details = current_line .. ":" .. current_col .. " "

      if current_line == 1 then
        return "  Top " .. details
      elseif current_line == vim.fn.line("$") then
        return "  Bot " .. details
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return "  " .. result .. "% " .. details
    end,
    highlight = { colors.statusline_bg, colors.base0B },
  },
}

table.insert(gls.right, unsaved)
table.insert(gls.right, git_icon)
table.insert(gls.right, git_branch)
table.insert(gls.right, line_percentage_sep)
table.insert(gls.right, line_percentage)
