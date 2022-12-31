local theme = require("themes." .. vim.g.colors_name)

local ok, _ = pcall(require, "colorbuddy")
if not ok then return end

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

---
-- Extra definitions
---

-- C Group
Group.new("cOperator", colors.base0C, colors.none, styles.NONE)
Group.new("cPreCondit", colors.base0E, colors.none, styles.NONE)

-- C# Group
Group.new("csClass", colors.base0A, colors.none, styles.NONE)
Group.new("csAttribute", colors.base0A, colors.none, styles.NONE)
Group.new("csModifier", colors.base0E, colors.none, styles.NONE)
Group.new("csType", colors.base08, colors.none, styles.NONE)
Group.new("csUnspecifiedStatement", colors.base0D, colors.none, styles.NONE)
Group.new("csContextualStatement", colors.base0E, colors.none, styles.NONE)
Group.new("csNewDecleration", colors.base08, colors.none, styles.NONE)

-- CSS Group
Group.new("cssBraces", colors.base05, colors.none, styles.NONE)
Group.new("cssClassName", colors.base0E, colors.none, styles.NONE)
Group.new("cssColor", colors.base0C, colors.none, styles.NONE)

-- Diff Group
Group.new("DiffAdd", colors.base0B, colors.none, styles.NONE)
Group.new("DiffChange", colors.sun, colors.none, styles.NONE)
Group.new("DiffDelete", colors.base08, colors.none, styles.NONE)
Group.new("DiffText", colors.base0D, colors.none, styles.NONE)
Group.new("DiffAdded", colors.base0B, colors.base00, styles.NONE)
Group.new("DiffFile", colors.base08, colors.base00, styles.NONE)
Group.new("DiffNewFile", colors.base0B, colors.base00, styles.NONE)
Group.new("DiffLine", colors.base0D, colors.base00, styles.NONE)
Group.new("DiffRemoved", colors.base08, colors.base00, styles.NONE)

-- Gitsigns
Group.new("GitSignsAddNr", colors.base0B, colors.none, styles.NONE)
Group.new("GitSignsChangeNr", colors.sun, colors.none, styles.NONE)
Group.new("GitSignsDeleteNr", colors.base08, colors.none, styles.NONE)
Group.new("GitSignsCurrentLineBlame", colors.base03, colors.none, styles.NONE)

-- Neogit
-- Group.new("NeogitDiffAddHighlight", groups.DiffAdd)
-- Group.new("NeogitDiffDeleteHighlight", groups.DiffDelete)
-- Group.new("NeogitDiffContextHighlight", colors.pink)
Group.new("NeogitHunkHeader", groups.DiffText)
Group.new("NeogitHunkHeaderHighlight", groups.DiffText)

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

-- GitGutter Group
Group.new("GitGutterAdd", colors.base0B, colors.base01, styles.NONE)
Group.new("GitGutterChange", colors.base0D, colors.base01, styles.NONE)
Group.new("GitGutterDelete", colors.base08, colors.base01, styles.NONE)
Group.new("GitGutterChangeDelete", colors.base0E, colors.base01, styles.NONE)

-- HTML Group
Group.new("htmlBold", colors.base0A, colors.none, styles.NONE)
Group.new("htmlItalic", colors.base0E, colors.none, styles.NONE)
Group.new("htmlEndTag", colors.base05, colors.none, styles.NONE)
Group.new("htmlTag", colors.base05, colors.none, styles.NONE)

-- JavaScript Group
Group.new("javaScript", colors.base05, colors.none, styles.NONE)
Group.new("javaScriptBraces", colors.base05, colors.none, styles.NONE)
Group.new("javaScriptNumber", colors.base09, colors.none, styles.NONE)
-- pangloss/vim-javascript Group
Group.new("jsOperator", colors.base0D, colors.none, styles.NONE)
Group.new("jsStatement", colors.base0E, colors.none, styles.NONE)
Group.new("jsReturn", colors.base0E, colors.none, styles.NONE)
Group.new("jsThis", colors.base08, colors.none, styles.NONE)
Group.new("jsClassDefinition", colors.base0A, colors.none, styles.NONE)
Group.new("jsFunction", colors.base0E, colors.none, styles.NONE)
Group.new("jsFuncName", colors.base0D, colors.none, styles.NONE)
Group.new("jsFuncCall", colors.base0D, colors.none, styles.NONE)
Group.new("jsClassFuncName", colors.base0D, colors.none, styles.NONE)
Group.new("jsClassMethodType", colors.base0E, colors.none, styles.NONE)
Group.new("jsRegexpString", colors.base0C, colors.none, styles.NONE)
Group.new("jsGlobalObjects", colors.base0A, colors.none, styles.NONE)
Group.new("jsGlobalNodeObjects", colors.base0A, colors.none, styles.NONE)
Group.new("jsExceptions", colors.base0A, colors.none, styles.NONE)
Group.new("jsBuiltins", colors.base0A, colors.none, styles.NONE)

-- Mail Group
Group.new("mailQuoted1", colors.base0A, colors.none, styles.NONE)
Group.new("mailQuoted2", colors.base0B, colors.none, styles.NONE)
Group.new("mailQuoted3", colors.base0E, colors.none, styles.NONE)
Group.new("mailQuoted4", colors.base0C, colors.none, styles.NONE)
Group.new("mailQuoted5", colors.base0D, colors.none, styles.NONE)
Group.new("mailQuoted6", colors.base0A, colors.none, styles.NONE)
Group.new("mailURL", colors.base0D, colors.none, styles.NONE)
Group.new("mailEmail", colors.base0D, colors.none, styles.NONE)

-- Markdown Group
Group.new("markdownCode", colors.base0B, colors.none, styles.NONE)
Group.new("markdownError", colors.base05, colors.base00, styles.NONE)
Group.new("markdownCodeBlock", colors.base0B, colors.none, styles.NONE)
Group.new("markdownHeadingDelimiter", colors.base0D, colors.none, styles.NONE)

-- PHP Group
Group.new("phpMemberSelector", colors.base05, colors.none, styles.NONE)
Group.new("phpComparison", colors.base05, colors.none, styles.NONE)
Group.new("phpParent", colors.base05, colors.none, styles.NONE)
Group.new("phpMethodsVar", colors.base0C, colors.none, styles.NONE)

-- Python Group
Group.new("pythonOperator", colors.base0E, colors.none, styles.NONE)
Group.new("pythonRepeat", colors.base0E, colors.none, styles.NONE)
Group.new("pythonInclude", colors.base0E, colors.none, styles.NONE)
Group.new("pythonStatement", colors.base0E, colors.none, styles.NONE)

-- Ruby Group
Group.new("rubyAttribute", colors.base0D, colors.none, styles.NONE)
Group.new("rubyConstant", colors.base0A, colors.none, styles.NONE)
Group.new("rubyInterpolationDelimiter", colors.base0F, colors.none, styles.NONE)
Group.new("rubyRegexp", colors.base0C, colors.none, styles.NONE)
Group.new("rubySymbol", colors.base0B, colors.none, styles.NONE)
Group.new("rubyStringDelimiter", colors.base0B, colors.none, styles.NONE)

-- SASS Group
Group.new("sassidChar", colors.base08, colors.none, styles.NONE)
Group.new("sassClassChar", colors.base09, colors.none, styles.NONE)
Group.new("sassInclude", colors.base0E, colors.none, styles.NONE)
Group.new("sassMixing", colors.base0E, colors.none, styles.NONE)
Group.new("sassMixinName", colors.base0D, colors.none, styles.NONE)

-- Signify Group
Group.new("SignifySignAdd", colors.base0B, colors.base01, styles.NONE)
Group.new("SignifySignChange", colors.base0D, colors.base01, styles.NONE)
Group.new("SignifySignDelete", colors.base08, colors.base01, styles.NONE)

-- Spelling Group
Group.new("SpellBad", colors.none, colors.none, styles.undercurl)
Group.new("SpellLocal", colors.none, colors.none, styles.undercurl)
Group.new("SpellCap", colors.none, colors.none, styles.undercurl)
Group.new("SpellRare", colors.none, colors.none, styles.undercurl)

-- Java Group
Group.new("javaOperator", colors.base0D, colors.none, styles.NONE)

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
Group.new("@function.macro", colors.base08, colors.none, styles.NONE)
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

-- LSP Semantic Highlighting
Group.new("@defaultLibrary", colors.base0C, colors.none, styles.NONE)
Group.new("@declaration", colors.base0A, colors.none, styles.NONE)

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

Group.new("TelescopePreviewBorder", colors.lightbg, colors.black, styles.NONE)
Group.new("TelescopePreviewLine", colors.none, colors.line, styles.NONE)
Group.new("TelescopePreviewTitle", colors.base08, colors.black, styles.NONE)

Group.new("TelescopeResultsBorder", colors.lightbg, colors.black, styles.NONE)
Group.new("TelescopeResultsTitle", colors.base08, colors.black, styles.NONE)

Group.new("TelescopePromptTitle", colors.base08, colors.black, styles.NONE)
Group.new("TelescopePromptBorder", colors.lightbg, colors.black, styles.NONE)
Group.new("TelescopePromptPrefix", colors.base08, colors.black, styles.NONE)
Group.new("TelescopePromptCounter", colors.base08, colors.black, styles.NONE)

Group.new("TeleDiffAdd", colors.base0B, colors.none, styles.NONE)
Group.new("TeleDiffChange", colors.sun, colors.none, styles.NONE)
Group.new("TeleDiffDelete", colors.base08, colors.none, styles.NONE)

-- symbols-outline
Group.new("FocusedSymbol", colors.base08, colors.line, styles.NONE)

-- vim-matchup
Group.new("MatchParen", colors.none, colors.grey, styles.NONE)

-- DAP
Group.new("DapBreakpoint", colors.base08, colors.none, styles.NONE)
