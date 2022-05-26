local vi_mode = require("feline.providers.vi_mode")
local git = require("feline.providers.git")
local gps = require("nvim-gps")

local colors = require("themes." .. vim.g.colors_name).colors
local utils = require("utils")
local Path = require("plenary.path")

gps.setup()

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 60 then
    return true
  end
  return false
end

local components = { active = {}, inactive = {} }

local vi = {
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
      hl = function()
        return { bg = vi_mode.get_mode_color() }
      end,
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

local current_dir = {
  provider = function()
    local max_len = 25
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    dir_name = utils.trim_TDAMPA(dir_name)
    if #dir_name > max_len then
      dir_name = dir_name:sub(0, max_len) .. "..."
    end
    return "  " .. dir_name .. " "
  end,
  hl = { fg = colors.grey_fg2, bg = colors.lightbg2 },
  right_sep = {
    str = "slant_right_2",
    hl = { fg = colors.lightbg2, bg = colors.statusline_bg },
  },
}

local git_diffs = {
  add = {
    provider = "git_diff_added",
    icon = " +",
    hl = { fg = colors.base0B, colors.statusline_bg },
  },
  mod = {
    provider = "git_diff_changed",
    icon = " ~",
    hl = { fg = colors.sun, colors.statusline_bg },
  },
  sub = {
    provider = "git_diff_removed",
    icon = " -",
    hl = { fg = colors.red, colors.statusline_bg },
  },
}

local diagnostics = {
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
    icon = "  ",
    hl = { fg = colors.green, bg = colors.statusline_bg },
  },
  info = {
    provider = "diagnostic_info",
    icon = "  ",
    hl = { fg = colors.purple, bg = colors.statusline_bg },
  },
}

local lsp_client = {
  provider = function()
    local clients = vim.lsp.get_active_clients()
    if #clients == 0 then
      return " No LSP "
    else
      return ""
    end
  end,
  hl = { fg = colors.grey_fg2, colors.statusline_bg },
}

local left = {
  vi,
  current_dir,
  git_diffs.add,
  git_diffs.mod,
  git_diffs.sub,
  diagnostics.errors,
  diagnostics.warns,
  diagnostics.hints,
  diagnostics.info,
  lsp_client,
}

local mid = {
  {
    provider = "file_name_custom",
    hl = { fg = colors.white, bg = colors.statusline_bg },
  },
}

local unsaved = {
  provider = function()
    local unsaved_cnt = utils.modified_buf_count()
    if unsaved_cnt > 0 then
      return "λ" .. unsaved_cnt
    end
    return ""
  end,
  update = { "BufEnter" },
  hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
  right_sep = {
    str = " ",
    hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
  },
}

local git_branch = {
  provider = function()
    local max_len = 25
    local branch = git.git_branch()
    branch = utils.trim_TDAMPA(branch)
    if #branch > max_len then
      branch = branch:sub(1, max_len) .. ".."
    end
    return " " .. branch .. " "
  end,
  enabled = function()
    return git.git_info_exists() and checkwidth()
  end,
  hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
}

local my_pos = {
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

local right = {
  unsaved,
  git_branch,
  my_pos,
}

table.insert(components.active, left)
table.insert(components.active, mid)
table.insert(components.active, right)

-- TODO: inactive stuff

local winbar_components = { active = {}, inactive = {} }

local winbar_left = {
  {
    provider = function()
      return gps.get_location()
    end,
    enabled = function()
      return gps.is_available()
    end,
    -- hl = { fg = colors.base00, bg = colors.base08 },
    hl = { bg = "NONE" },
  },
}

local winbar_right = {
  {
    provider = "file_name_simple",
    hl = { fg = colors.base00, bg = colors.base08 },
  },
}

local winbar_inactive = {
  {
    provider = "file_name_simple",
    hl = { fg = colors.white, bg = "NONE" },
  },
}

table.insert(winbar_components.active, winbar_left)
table.insert(winbar_components.active, winbar_right)
table.insert(winbar_components.inactive, {})
table.insert(winbar_components.inactive, winbar_inactive)

-- Setup feline.nvim
require("feline").setup({
  components = components,
  theme = {
    fg = colors.grey_fg2,
    bg = colors.statusline_bg,
    lightgray = "#323232",
    gray = "#131619",
    blue = "#506275",
    green = "#5E9274",
    cyan = "#51AAAB",
    purple = "#78558C",
    darkpurple = "#67217A",
  },
  force_inactive = {
    filetypes = {
      "^NvimTree$",
      "^packer$",
      "^startify$",
      "^fugitive$",
      "^fugitiveblame$",
      "^qf$",
      "^help$",
    },
    buftypes = {
      -- "^terminal$",
      "^nofile$",
    },
  },
  vi_mode_colors = {
    ["NORMAL"] = colors.nord_blue,
    ["OP"] = "green",
    ["INSERT"] = colors.green,
    ["VISUAL"] = colors.blue,
    ["LINES"] = "skyblue",
    ["BLOCK"] = colors.blue,
    ["REPLACE"] = colors.teal,
    ["V-REPLACE"] = colors.teal,
    ["ENTER"] = "cyan",
    ["MORE"] = "cyan",
    ["SELECT"] = colors.dark_purple,
    ["COMMAND"] = colors.white,
    ["SHELL"] = "green",
    ["TERM"] = colors.red,
    ["NONE"] = "yellow",
  },
  custom_providers = {
    file_name_custom = function()
      local prefix, filename, suffix = "", vim.fn.expand("%:p"), ""

      prefix = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype) or ""
      local max_len = checkwidth() and 75 or 50
      filename = Path:new(filename):make_relative(vim.loop.cwd())
      if #filename > max_len then
        filename = Path:new(filename):shorten()
      end

      if vim.bo.modifiable then
        if vim.bo.modified then
          suffix = ""
        end
      else
        suffix = ""
      end

      return string.format("%s %s %s", prefix, filename, suffix)
    end,
    file_name_simple = function()
      local prefix, filename, suffix = "", vim.fn.expand("%"), ""

      if vim.bo.modifiable then
        if vim.bo.modified then
          prefix = "[+]"
        end
      else
        prefix = "[-]"
      end

      return string.format("%s %s %s", prefix, filename, suffix)
    end,
  },
})

require("feline").winbar.setup({
  components = winbar_components,
})
