local theme = require("themes." .. vim.g.colors_name)
local colors = theme.colors

local mycomps = require("jfeline.components")

local components = { active = {}, inactive = {} }

local left = {
  mycomps.vi,
  mycomps.current_dir,
  mycomps.git_diffs.add,
  mycomps.git_diffs.mod,
  mycomps.git_diffs.sub,
  mycomps.diagnostics.errors,
  mycomps.diagnostics.warns,
  mycomps.diagnostics.hints,
  mycomps.diagnostics.info,
  mycomps.lsp_client,
}

local mid = {
  mycomps.file_name,
}

local right = {
  mycomps.unsaved,
  mycomps.git_branch,
  mycomps.my_pos,
}

table.insert(components.active, left)
table.insert(components.active, mid)
table.insert(components.active, right)
table.insert(components.inactive, { mycomps.vi })
table.insert(components.inactive, { mycomps.unsaved, mycomps.my_pos })

-- TODO: inactive stuff
require("feline").setup({
  components = components,
  theme = colors,
  force_inactive = {
    filetypes = {
      "^packer$",
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
  vi_mode_colors = theme.vi_mode_colors,
})

--[[ WINBAR ]]
local winbar_components = { active = {}, inactive = {} }
table.insert(winbar_components.active, mycomps.winbar_left)
table.insert(winbar_components.active, mycomps.winbar_right)
table.insert(winbar_components.inactive, {})
table.insert(winbar_components.inactive, mycomps.winbar_inactive)

-- require("feline").winbar.setup({
--   components = winbar_components,
-- })
