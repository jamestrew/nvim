local M = { "tjdevries/colorbuddy.vim", priority = 100 }

M.init = function()
  if false then
    vim.cmd.colorscheme("habamax")
    return
  end
  local theme = require("themes." .. vim.g.colors_name)

  local Color, colors, Group, groups, styles = require("colorbuddy").setup()
  local v = vim

  for name, hex in pairs(theme.colors) do
    Color.new(name, hex)
  end

  --[[
Usage:
```
  Color.new('background',  '#282c34')
  Group.new('HighlightGroupName',  colors.foreground, colors.background, styles.bold)
```
]]
  -- Vim editor colors
  Group.new("Normal", colors.base05, colors.black, styles.NONE)
  Group.new("Bold", colors.none, colors.none, styles.bold)
  Group.new("Debug", colors.base08, colors.none, styles.NONE)
  Group.new("Directory", colors.base0D, colors.none, styles.NONE)
  Group.new("Error", colors.base00, colors.base08, styles.NONE)
  Group.new("ErrorMsg", colors.base08, colors.base00, styles.NONE)
  Group.new("Exception", colors.base08, colors.none, styles.NONE)
  Group.new("FoldColumn", colors.base0C, colors.base01, styles.NONE)
  Group.new("Folded", colors.base03, colors.base01, styles.NONE)
  Group.new("IncSearch", colors.base01, colors.base09, styles.NONE)
  Group.new("Italic", colors.none, colors.none, styles.italic)
  Group.new("Macro", colors.base08, colors.none, styles.NONE)
  Group.new("MatchParen", colors.none, colors.base03, styles.NONE)
  Group.new("ModeMsg", colors.base0B, colors.none, styles.NONE)
  Group.new("MoreMsg", colors.base0B, colors.none, styles.NONE)
  Group.new("Question", colors.base0D, colors.none, styles.NONE)
  Group.new("Search", colors.base01, colors.base0A, styles.NONE)
  Group.new("Substitute", colors.base01, colors.base0A, styles.NONE)
  Group.new("SpecialKey", colors.base03, colors.none, styles.NONE)
  Group.new("TooLong", colors.base08, colors.none, styles.NONE)
  Group.new("Underlined", colors.base08, colors.none, styles.NONE)
  Group.new("Visual", colors.none, colors.base02, styles.NONE)
  Group.new("VisualNOS", colors.base08, colors.none, styles.NONE)
  Group.new("WarningMsg", colors.base08, colors.none, styles.NONE)
  Group.new("WildMenu", colors.base08, colors.base0A, styles.NONE)
  Group.new("Title", colors.base0D, colors.none, styles.NONE)
  Group.new("Conceal", colors.base0D, colors.base00, styles.NONE)
  Group.new("Cursor", colors.base00, colors.base05, styles.NONE)
  Group.new("NonText", colors.base03, colors.none, styles.NONE)
  Group.new("LineNr", colors.grey, colors.none, styles.NONE)
  Group.new("SignColumn", colors.base03, colors.black, styles.NONE)
  -- Group.new("StatusLine", colors.base04, colors.statusline_bg, styles.NONE)
  -- Group.new("StatusLineNC", colors.base04, colors.black, styles.underline)
  Group.new("VertSplit", colors.line, colors.black, styles.NONE)
  Group.new("ColorColumn", colors.none, colors.base01, styles.NONE)
  Group.new("CursorColumn", colors.none, colors.base01, styles.NONE)
  Group.new("CursorLine", colors.none, colors.line, styles.NONE)
  Group.new("CursorLineNr", colors.base04, colors.line, styles.NONE)
  Group.new("QuickFixLine", colors.none, colors.base01, styles.NONE)
  Group.new("PMenu", colors.base05, colors.one_bg, styles.NONE)
  Group.new("PMenuSel", colors.base01, colors.green, styles.NONE)
  Group.new("PmenuSbar", colors.none, colors.one_bg2, styles.NONE)
  Group.new("PmenuThumb", colors.none, colors.nord_blue, styles.NONE)
  Group.new("TabLine", colors.base03, colors.base01, styles.NONE)
  Group.new("TabLineFill", colors.base03, colors.base01, styles.NONE)
  Group.new("TabLineSel", colors.base0B, colors.base01, styles.NONE)

  -- Standard syntax Group
  Group.new("Boolean", colors.base09, colors.none, styles.NONE)
  Group.new("Character", colors.base08, colors.none, styles.NONE)
  Group.new("Comment", colors.grey_fg2, colors.none, styles.NONE)
  Group.new("Conditional", colors.base0E, colors.none, styles.NONE)
  Group.new("Constant", colors.base09, colors.none, styles.NONE)
  Group.new("Define", colors.base0E, colors.none, styles.NONE)
  Group.new("Delimiter", colors.base0F, colors.none, styles.NONE)
  Group.new("Float", colors.base09, colors.none, styles.NONE)
  Group.new("Function", colors.base0D, colors.none, styles.NONE)
  Group.new("Identifier", colors.base08, colors.none, styles.NONE)
  Group.new("Include", colors.base0D, colors.none, styles.NONE)
  Group.new("Keyword", colors.base0E, colors.none, styles.NONE)
  Group.new("Label", colors.base0A, colors.none, styles.NONE)
  Group.new("Number", colors.base09, colors.none, styles.NONE)
  Group.new("Operator", colors.base05, colors.none, styles.NONE)
  Group.new("PreProc", colors.base0A, colors.none, styles.NONE)
  Group.new("Repeat", colors.base0A, colors.none, styles.NONE)
  Group.new("Special", colors.base0C, colors.none, styles.NONE)
  Group.new("SpecialChar", colors.base0F, colors.none, styles.NONE)
  Group.new("Statement", colors.base08, colors.none, styles.NONE)
  Group.new("StorageClass", colors.base0A, colors.none, styles.NONE)
  Group.new("String", colors.base0B, colors.none, styles.NONE)
  Group.new("Structure", colors.base0E, colors.none, styles.NONE)
  Group.new("Tag", colors.base0A, colors.none, styles.NONE)
  Group.new("Todo", colors.base0A, colors.base01, styles.NONE)
  Group.new("Type", colors.base0A, colors.none, styles.NONE)
  Group.new("Typedef", colors.base0A, colors.none, styles.NONE)

  -- Diff Group
  local function diff_bg(color)
    for _ = 0, 4 do
      color = color:average(colors.black)
    end
    return color
  end

  Group.new("DiffAdd", colors.none, diff_bg(colors.base0B), styles.NONE)
  Group.new("DiffChange", colors.none, diff_bg(colors.sun), styles.NONE)
  Group.new("DiffDelete", colors.base08, diff_bg(colors.base08), styles.NONE)
  Group.new("DiffText", colors.none, colors.lightbg, styles.NONE)

  Group.new("DiffAdded", colors.base0B)
  Group.new("DiffChanged", colors.sun)
  Group.new("DiffRemoved", colors.base08)

  -- Gitsigns
  Group.new("GitSignsAdd", colors.base0B, colors.none, styles.NONE)
  Group.new("GitSignsChange", colors.sun, colors.none, styles.NONE)
  Group.new("GitSignsDelete", colors.base08, colors.none, styles.NONE)
  Group.new("GitSignsCurrentLineBlame", colors.base03, colors.none, styles.NONE)

  -- Git Group
  Group.new("gitcommitOverflow", colors.base08, colors.none, styles.NONE)
  Group.new("gitcommitSummary", colors.base0B, colors.none, styles.NONE)
  Group.new("gitcommitComment", colors.base03, colors.none, styles.NONE)
  Group.new("gitcommitUntracked", colors.base03, colors.none, styles.NONE)
  Group.new("gitcommitDiscarded", colors.base03, colors.none, styles.NONE)
  Group.new("gitcommitSelected", colors.base03, colors.none, styles.NONE)
  Group.new("gitcommitHeader", colors.base0E, colors.none, styles.NONE)
  Group.new("gitcommitSelectedType", colors.base0D, colors.none, styles.NONE)
  Group.new("gitcommitUnmergedType", colors.base0D, colors.none, styles.NONE)
  Group.new("gitcommitDiscardedType", colors.base0D, colors.none, styles.NONE)
  Group.new("gitcommitBranch", colors.base09, colors.none, styles.bold)
  Group.new("gitcommitUntrackedFile", colors.base0A, colors.none, styles.NONE)
  Group.new("gitcommitUnmergedFile", colors.base08, colors.none, styles.bold)
  Group.new("gitcommitDiscardedFile", colors.base08, colors.none, styles.bold)
  Group.new("gitcommitSelectedFile", colors.base0B, colors.none, styles.bold)

  -- Spelling Group
  Group.new("SpellBad", colors.none, colors.none, styles.undercurl)
  Group.new("SpellLocal", colors.none, colors.none, styles.undercurl)
  Group.new("SpellCap", colors.none, colors.none, styles.undercurl)
  Group.new("SpellRare", colors.none, colors.none, styles.undercurl)

  -- treesitter
  Group.new("@none", colors.base05, colors.none, styles.NONE)
  Group.new("@punction.delimiter", colors.base08, colors.none, styles.NONE)
  Group.new("@punction.bracket", colors.base08, colors.none, styles.NONE)
  Group.new("@punction.special", colors.base0F, colors.none, styles.NONE)
  Group.new("@constant", colors.base09, colors.none, styles.bold)
  Group.new("@constant.builtin", colors.base0C, colors.none, styles.NONE)
  Group.new("@constant.macro", colors.base0E, colors.none, styles.NONE)
  Group.new("@string", colors.base0B, colors.none, styles.NONE)
  Group.new("@string.regex", colors.base0B, colors.none, styles.NONE)
  Group.new("@string.escape", colors.base0F, colors.none, styles.NONE)
  Group.new("@character", colors.base08, colors.none, styles.NONE)
  Group.new("@number", colors.base09, colors.none, styles.NONE)
  Group.new("@boolean", colors.base0C, colors.none, styles.bold)
  Group.new("@float", colors.base0B, colors.none, styles.NONE)
  Group.new("@function", colors.base0D, colors.none, styles.bold)
  Group.new("@function.builtin", colors.base0C, colors.none, styles.NONE)
  Group.new("@function.macro", colors.base0D, colors.none, styles.NONE)
  Group.new("@macro", colors.base0D, colors.none, styles.bold)
  Group.new("@parameter", colors.base08, colors.none, styles.NONE)
  Group.new("@parameter.reference", colors.base08, colors.none, styles.NONE)
  Group.new("@method", colors.base0D, colors.none, styles.bold)
  Group.new("@field", colors.base0A, colors.none, styles.NONE)
  Group.new("@property", colors.base0A, colors.none, styles.NONE)
  Group.new("@constructor", colors.base0C, colors.none, styles.NONE)
  Group.new("@annotation", colors.base0A, colors.none, styles.NONE)
  Group.new("@attribute", colors.base0A, colors.none, styles.NONE)
  Group.new("@namespace", colors.base0D, colors.none, styles.NONE)
  Group.new("@conditional", colors.base0E, colors.none, styles.NONE)
  Group.new("@repeat", colors.base0D, colors.none, styles.NONE)
  Group.new("@label", colors.base0A, colors.none, styles.NONE)
  Group.new("@operator", colors.base07, colors.none, styles.NONE)
  Group.new("@keyword", colors.base0E, colors.none, styles.NONE)
  Group.new("@keyword.function", colors.base0E, colors.none, styles.bold)
  Group.new("@keyword.operator", colors.base08, colors.none, styles.NONE)
  Group.new("@exception", colors.base08, colors.none, styles.NONE)
  Group.new("@type", colors.base0A, colors.none, styles.bold)
  Group.new("@type.builtin", colors.base0A, colors.none, styles.bold)
  Group.new("@include", colors.base0D, colors.none, styles.NONE)
  Group.new("@variable", colors.none, colors.none, styles.NONE)
  Group.new("@variable.builtin", colors.base0C, colors.none, styles.NONE)
  Group.new("@text", colors.base05, colors.none, styles.NONE)
  Group.new("@strong", colors.base07, colors.none, styles.bold)
  Group.new("@emphasis", colors.base06, colors.none, styles.italic)
  Group.new("@underline", colors.base05, colors.none, styles.underline)
  Group.new("@title", colors.base0D, colors.none, styles.NONE)
  Group.new("@literal", colors.base0B, colors.none, styles.NONE)
  Group.new("@uri", colors.base08, colors.none, styles.NONE)
  Group.new("@tag", colors.base0A, colors.none, styles.NONE)
  Group.new("@tag.delimiter", colors.base0F, colors.none, styles.NONE)
  Group.new("@definition", colors.base01, colors.base0A, styles.NONE)
  Group.new("@definition.usage", colors.none, colors.base02, styles.NONE)
  Group.new("@currentscope", colors.none, colors.base01, styles.NONE)

  -- Semantic Tokens
  Group.new("@lsp.type.namespace", groups["@namespace"], groups["@namespace"], groups["@namespace"])
  Group.new("@lsp.type.type", groups["@type"], groups["@type"], groups["@type"])
  Group.new("@lsp.type.class", groups["@type"], groups["@type"], groups["@type"])
  Group.new("@lsp.type.enum", groups["@type"], groups["@type"], groups["@type"])
  Group.new("@lsp.type.interface", groups["@type"], groups["@type"], groups["@type"])
  Group.new("@lsp.type.parameter", groups["@parameter"], groups["@parameter"], groups["@parameter"])
  Group.new("@lsp.type.variable", groups["@variable"], groups["@variable"], groups["@variable"])
  Group.new("@lsp.type.property", groups["@property"], groups["@property"], groups["@property"])
  Group.new("@lsp.type.enumMember", groups["@constant"], groups["@constant"], groups["@constant"])
  Group.new("@lsp.type.function", groups["@function"], groups["@function"], groups["@function"])
  Group.new("@lsp.type.decorator", groups["@function"], groups["@function"], groups["@function"])
  Group.new("@lsp.type.method", groups["@method"], groups["@method"], groups["@method"])
  Group.new("@lsp.type.macro", groups["@macro"], groups["@macro"], groups["@macro"])

  -- LSP Diagnostics
  Group.new("DiagnosticError", colors.red, colors.none, styles.NONE)
  Group.new("DiagnosticWarn", colors.yellow, colors.none, styles.NONE)
  Group.new("DiagnosticInfo", colors.blue, colors.none, styles.NONE)
  Group.new("DiagnosticHint", colors.purple, colors.none, styles.NONE)
  Group.new("DiagnosticVirtualTextError", colors.red, colors.none, styles.NONE)
  Group.new("DiagnosticVirtualTextWarn", colors.yellow, colors.none, styles.NONE)
  Group.new("DiagnosticVirtualTextInfo", colors.blue, colors.none, styles.NONE)
  Group.new("DiagnosticVirtualTextHint", colors.purple, colors.none, styles.NONE)
  Group.new("DiagnosticUnderlineError", colors.red, colors.none, styles.underline)
  Group.new("DiagnosticUnderlineWarn", colors.yellow, colors.none, styles.underline)
  Group.new("DiagnosticUnderlineInfo", colors.blue, colors.none, styles.underline)
  Group.new("DiagnosticUnderlineHint", colors.purple, colors.none, styles.underline)
  Group.new("DiagnosticFloatingError", colors.red, groups.pmenu, styles.underline)
  Group.new("DiagnosticFloatingWarn", colors.yellow, groups.pmenu, styles.underline)
  Group.new("DiagnosticFloatingInfo", colors.blue, groups.pmenu, styles.underline)
  Group.new("DiagnosticFloatingHint", colors.purple, groups.pmenu, styles.underline)
  Group.new("DiagnosticSignError", colors.red, colors.none, styles.NONE)
  Group.new("DiagnosticSignWarn", colors.yellow, colors.none, styles.NONE)
  Group.new("DiagnosticSignInfo", colors.blue, colors.none, styles.NONE)
  Group.new("DiagnosticSignHint", colors.purple, colors.none, styles.NONE)

  -- Terminal
  v.g.terminal_color_0 = theme.base00
  v.g.terminal_color_1 = theme.base08
  v.g.terminal_color_2 = theme.base0B
  v.g.terminal_color_3 = theme.base0A
  v.g.terminal_color_4 = theme.base0D
  v.g.terminal_color_5 = theme.base0E
  v.g.terminal_color_6 = theme.base0C
  v.g.terminal_color_7 = theme.base05
  v.g.terminal_color_8 = theme.base03
  v.g.terminal_color_9 = theme.base08
  v.g.terminal_color_10 = theme.base0B
  v.g.terminal_color_11 = theme.base0A
  v.g.terminal_color_12 = theme.base0D
  v.g.terminal_color_13 = theme.base0E
  v.g.terminal_color_14 = theme.base0C
  v.g.terminal_color_15 = theme.base07

  -- blankline
  Group.new("IndentBlanklineChar", colors.line, colors.none, styles.NONE)
  Group.new("IndentBlanklineContextChar", colors.base0E, colors.none, styles.NONE)
  Group.new("IndentBlanklineContextStart", colors.none, colors.none, styles.NONE)

  -- misc
  Group.new("NvimInternalError", colors.red, colors.none, styles.NONE)
  Group.new("EndOfBuffer", colors.black, colors.none, styles.NONE)

  -- telescope
  Group.new("TelescopeNormal", colors.none, colors.black, styles.NONE)
  Group.new("TelescopeBorder", colors.lightbg, colors.black, styles.NONE)
  Group.new("TelescopeSelection", colors.none, colors.line, styles.NONE)
  Group.new("TelescopeTitle", colors.base08, colors.none, styles.NONE)
  Group.new("TelescopeMatching", colors.base0C, colors.none, styles.NONE)

  Group.new("TelescopePreviewBorder", colors.lightbg, colors.black, styles.NONE)
  Group.new("TelescopePreviewLine", colors.none, colors.line, styles.NONE)
  Group.new("TelescopePreviewTitle", colors.base08, colors.black, styles.NONE)
  Group.new("TelescopePreviewLink", colors.base08, colors.black, styles.NONE)

  Group.new("TelescopeResultsBorder", colors.lightbg, colors.black, styles.NONE)
  Group.new("TelescopeResultsTitle", colors.base08, colors.black, styles.NONE)
  Group.new("TelescopeResultsIdentifier", colors.base08, colors.none, styles.NONE)

  Group.new("TelescopePromptTitle", colors.base08, colors.black, styles.NONE)
  Group.new("TelescopePromptBorder", colors.lightbg, colors.black, styles.NONE)
  Group.new("TelescopePromptPrefix", colors.base08, colors.black, styles.NONE)
  Group.new("TelescopePromptCounter", colors.base08, colors.black, styles.NONE)

  Group.new("TelescopeResultsDiffAdd", colors.base0B, colors.none, styles.NONE)
  Group.new("TelescopeResultsDiffChange", colors.sun, colors.none, styles.NONE)
  Group.new("TelescopeResultsDiffDelete", colors.base08, colors.none, styles.NONE)

  -- symbols-outline
  Group.new("FocusedSymbol", colors.base08, colors.line, styles.NONE)

  -- vim-matchup
  Group.new("MatchParen", colors.none, colors.grey, styles.NONE)

  -- DAP
  Group.new("DapBreakpoint", colors.base08, colors.none, styles.NONE)

  Group.new("BufferLineFill", colors.none, colors.statusline_bg)

  -- Cmp
  Group.new("CmpItemAbbrDefault", colors.base05, colors.none, styles.NONE)
  Group.new("CmpBorder", colors.red, colors.one_bg, styles.NONE)
  Group.new("CmpItemAbbr", colors.white)
  Group.new("CmpItemAbbrMatch", colors.blue, colors.none, styles.bold)
  Group.new("CmpBorder", colors.grey)
  Group.new("CmpDocBorder", colors.darker_black, colors.darker_black, styles.NONE)
  Group.new("CmPmenu", colors.none, colors.darker_black, styles.NONE)
  Group.new("CmpItemKindConstant", colors.base09)
  Group.new("CmpItemKindFunction", colors.base0D)
  Group.new("CmpItemKindIdentifier", colors.base08)
  Group.new("CmpItemKindField", colors.base08)
  Group.new("CmpItemKindVariable", colors.base0E)
  Group.new("CmpItemKindSnippet", colors.red)
  Group.new("CmpItemKindText", colors.base0B)
  Group.new("CmpItemKindStructure", colors.base0E)
  Group.new("CmpItemKindType", colors.base0A)
  Group.new("CmpItemKindKeyword", colors.base07)
  Group.new("CmpItemKindMethod", colors.base0D)
  Group.new("CmpItemKindConstructor", colors.blue)
  Group.new("CmpItemKindFolder", colors.base07)
  Group.new("CmpItemKindModule", colors.base0A)
  Group.new("CmpItemKindProperty", colors.base08)
  Group.new("CmpItemKindUnit", colors.base0E)
  Group.new("CmpItemKindFile", colors.base07)
  Group.new("CmpItemKindColor", colors.red)
  Group.new("CmpItemKindReference", colors.base05)
  Group.new("CmpItemKindStruct", colors.base0E)
  Group.new("CmpItemKindOperator", colors.base05)
  Group.new("CmpItemKindTypeParameter", colors.base08)
  Group.new("CmpItemKindCopilot", colors.green)
end

return M
