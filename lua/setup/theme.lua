local theme = require("themes.onedark")

local Color, colors, Group, groups, styles = require("colorbuddy").setup()
local bold = styles.bold
local italics = styles.italic
local inverse = styles.inverse
local undercurl = styles.undercurl
local underline = styles.underline
local reverse = styles.reverse
local standout = styles.standout
local none = styles.NONE
local v = vim

v.g.colors_name = theme.name
for name, hex in pairs(theme.colors) do
  Color.new(name, hex)
end

-- Vim editor colors
Group.new("Normal", colors.base05, colors.black, none)
Group.new("Bold", colors.none, colors.none, bold)
Group.new("Debug", colors.base08, colors.none, none)
Group.new("Directory", colors.base0D, colors.none, none)
Group.new("Error", colors.base00, colors.base08, none)
Group.new("ErrorMsg", colors.base08, colors.base00, none)
Group.new("Exception", colors.base08, colors.none, none)
Group.new("FoldColumn", colors.base0C, colors.base01, none)
Group.new("Folded", colors.base03, colors.base01, none)
Group.new("IncSearch", colors.base01, colors.base09, none)
Group.new("Italic", colors.none, colors.none, italics)
Group.new("Macro", colors.base08, colors.none, none)
Group.new("MatchParen", colors.none, colors.base03, none)
Group.new("ModeMsg", colors.base0B, colors.none, none)
Group.new("MoreMsg", colors.base0B, colors.none, none)
Group.new("Question", colors.base0D, colors.none, none)
Group.new("Search", colors.base01, colors.base0A, none)
Group.new("Substitute", colors.base01, colors.base0A, none)
Group.new("SpecialKey", colors.base03, colors.none, none)
Group.new("TooLong", colors.base08, colors.none, none)
Group.new("Underlined", colors.base08, colors.none, none)
Group.new("Visual", colors.none, colors.base02, none)
Group.new("VisualNOS", colors.base08, colors.none, none)
Group.new("WarningMsg", colors.base08, colors.none, none)
Group.new("WildMenu", colors.base08, colors.base0A, none)
Group.new("Title", colors.base0D, colors.none, none)
Group.new("Conceal", colors.base0D, colors.base00, none)
Group.new("Cursor", colors.base00, colors.base05, none)
Group.new("NonText", colors.base03, colors.none, none)
Group.new("LineNr", colors.grey, colors.none, none)
Group.new("SignColumn", colors.base03, colors.black, none)
Group.new("StatusLine", colors.base04, colors.base02, none)
Group.new("StatusLineNC", colors.base03, colors.black, none)
Group.new("VertSplit", colors.line, colors.black, none)
Group.new("ColorColumn", colors.none, colors.base01, none)
Group.new("CursorColumn", colors.none, colors.base01, none)
Group.new("CursorLine", colors.none, colors.line, none)
Group.new("CursorLineNr", colors.base04, colors.line, none)
Group.new("QuickFixLine", colors.none, colors.base01, none)
Group.new("PMenu", colors.base05, colors.one_bg, none)
Group.new("PMenuSel", colors.base01, colors.green, none)
Group.new("PmenuSbar", colors.none, colors.one_bg2, none)
Group.new("PmenuThumb", colors.none, colors.nord_blue, none)
Group.new("TabLine", colors.base03, colors.base01, none)
Group.new("TabLineFill", colors.base03, colors.base01, none)
Group.new("TabLineSel", colors.base0B, colors.base01, none)

-- Standard syntax Group.newing
Group.new("Boolean", colors.base09, colors.none, none)
Group.new("Character", colors.base08, colors.none, none)
Group.new("Comment", colors.grey_fg2, colors.none, none)
Group.new("Conditional", colors.base0E, colors.none, none)
Group.new("Constant", colors.base09, colors.none, none)
Group.new("Define", colors.base0E, colors.none, none)
Group.new("Delimiter", colors.base0F, colors.none, none)
Group.new("Float", colors.base09, colors.none, none)
Group.new("Function", colors.base0D, colors.none, none)
Group.new("Identifier", colors.base08, colors.none, none)
Group.new("Include", colors.base0D, colors.none, none)
Group.new("Keyword", colors.base0E, colors.none, none)
Group.new("Label", colors.base0A, colors.none, none)
Group.new("Number", colors.base09, colors.none, none)
Group.new("Operator", colors.base05, colors.none, none)
Group.new("PreProc", colors.base0A, colors.none, none)
Group.new("Repeat", colors.base0A, colors.none, none)
Group.new("Special", colors.base0C, colors.none, none)
Group.new("SpecialChar", colors.base0F, colors.none, none)
Group.new("Statement", colors.base08, colors.none, none)
Group.new("StorageClass", colors.base0A, colors.none, none)
Group.new("String", colors.base0B, colors.none, none)
Group.new("Structure", colors.base0E, colors.none, none)
Group.new("Tag", colors.base0A, colors.none, none)
Group.new("Todo", colors.base0A, colors.base01, none)
Group.new("Type", colors.base0A, colors.none, none)
Group.new("Typedef", colors.base0A, colors.none, none)

---
-- Extra definitions
---

-- C Group.newing
Group.new("cOperator", colors.base0C, colors.none, none)
Group.new("cPreCondit", colors.base0E, colors.none, none)

-- C# Group.newing
Group.new("csClass", colors.base0A, colors.none, none)
Group.new("csAttribute", colors.base0A, colors.none, none)
Group.new("csModifier", colors.base0E, colors.none, none)
Group.new("csType", colors.base08, colors.none, none)
Group.new("csUnspecifiedStatement", colors.base0D, colors.none, none)
Group.new("csContextualStatement", colors.base0E, colors.none, none)
Group.new("csNewDecleration", colors.base08, colors.none, none)

-- CSS Group.newing
Group.new("cssBraces", colors.base05, colors.none, none)
Group.new("cssClassName", colors.base0E, colors.none, none)
Group.new("cssColor", colors.base0C, colors.none, none)

-- Diff Group.newing
Group.new("DiffAdd", colors.base0B, colors.base01, none)
Group.new("DiffChange", colors.sun, colors.base01, none)
Group.new("DiffDelete", colors.base08, colors.base01, none)
Group.new("DiffText", colors.base0D, colors.base01, none)
Group.new("DiffAdded", colors.base0B, colors.base00, none)
Group.new("DiffFile", colors.base08, colors.base00, none)
Group.new("DiffNewFile", colors.base0B, colors.base00, none)
Group.new("DiffLine", colors.base0D, colors.base00, none)
Group.new("DiffRemoved", colors.base08, colors.base00, none)

-- Git Group.newing
Group.new("gitcommitOverflow", colors.base08, colors.none, none)
Group.new("gitcommitSummary", colors.base0B, colors.none, none)
Group.new("gitcommitComment", colors.base03, colors.none, none)
Group.new("gitcommitUntracked", colors.base03, colors.none, none)
Group.new("gitcommitDiscarded", colors.base03, colors.none, none)
Group.new("gitcommitSelected", colors.base03, colors.none, none)
Group.new("gitcommitHeader", colors.base0E, colors.none, none)
Group.new("gitcommitSelectedType", colors.base0D, colors.none, none)
Group.new("gitcommitUnmergedType", colors.base0D, colors.none, none)
Group.new("gitcommitDiscardedType", colors.base0D, colors.none, none)
Group.new("gitcommitBranch", colors.base09, colors.none, bold)
Group.new("gitcommitUntrackedFile", colors.base0A, colors.none, none)
Group.new("gitcommitUnmergedFile", colors.base08, colors.none, bold)
Group.new("gitcommitDiscardedFile", colors.base08, colors.none, bold)
Group.new("gitcommitSelectedFile", colors.base0B, colors.none, bold)

-- GitGutter Group.newing
Group.new("GitGutterAdd", colors.base0B, colors.base01, none)
Group.new("GitGutterChange", colors.base0D, colors.base01, none)
Group.new("GitGutterDelete", colors.base08, colors.base01, none)
Group.new("GitGutterChangeDelete", colors.base0E, colors.base01, none)

-- HTML Group.newing
Group.new("htmlBold", colors.base0A, colors.none, none)
Group.new("htmlItalic", colors.base0E, colors.none, none)
Group.new("htmlEndTag", colors.base05, colors.none, none)
Group.new("htmlTag", colors.base05, colors.none, none)

-- JavaScript Group.newing
Group.new("javaScript", colors.base05, colors.none, none)
Group.new("javaScriptBraces", colors.base05, colors.none, none)
Group.new("javaScriptNumber", colors.base09, colors.none, none)
-- pangloss/vim-javascript Group.newing
Group.new("jsOperator", colors.base0D, colors.none, none)
Group.new("jsStatement", colors.base0E, colors.none, none)
Group.new("jsReturn", colors.base0E, colors.none, none)
Group.new("jsThis", colors.base08, colors.none, none)
Group.new("jsClassDefinition", colors.base0A, colors.none, none)
Group.new("jsFunction", colors.base0E, colors.none, none)
Group.new("jsFuncName", colors.base0D, colors.none, none)
Group.new("jsFuncCall", colors.base0D, colors.none, none)
Group.new("jsClassFuncName", colors.base0D, colors.none, none)
Group.new("jsClassMethodType", colors.base0E, colors.none, none)
Group.new("jsRegexpString", colors.base0C, colors.none, none)
Group.new("jsGlobalObjects", colors.base0A, colors.none, none)
Group.new("jsGlobalNodeObjects", colors.base0A, colors.none, none)
Group.new("jsExceptions", colors.base0A, colors.none, none)
Group.new("jsBuiltins", colors.base0A, colors.none, none)

-- Mail Group.newing
Group.new("mailQuoted1", colors.base0A, colors.none, none)
Group.new("mailQuoted2", colors.base0B, colors.none, none)
Group.new("mailQuoted3", colors.base0E, colors.none, none)
Group.new("mailQuoted4", colors.base0C, colors.none, none)
Group.new("mailQuoted5", colors.base0D, colors.none, none)
Group.new("mailQuoted6", colors.base0A, colors.none, none)
Group.new("mailURL", colors.base0D, colors.none, none)
Group.new("mailEmail", colors.base0D, colors.none, none)

-- Markdown Group.newing
Group.new("markdownCode", colors.base0B, colors.none, none)
Group.new("markdownError", colors.base05, colors.base00, none)
Group.new("markdownCodeBlock", colors.base0B, colors.none, none)
Group.new("markdownHeadingDelimiter", colors.base0D, colors.none, none)

-- PHP Group.newing
Group.new("phpMemberSelector", colors.base05, colors.none, none)
Group.new("phpComparison", colors.base05, colors.none, none)
Group.new("phpParent", colors.base05, colors.none, none)
Group.new("phpMethodsVar", colors.base0C, colors.none, none)

-- Python Group.newing
Group.new("pythonOperator", colors.base0E, colors.none, none)
Group.new("pythonRepeat", colors.base0E, colors.none, none)
Group.new("pythonInclude", colors.base0E, colors.none, none)
Group.new("pythonStatement", colors.base0E, colors.none, none)

-- Ruby Group.newing
Group.new("rubyAttribute", colors.base0D, colors.none, none)
Group.new("rubyConstant", colors.base0A, colors.none, none)
Group.new("rubyInterpolationDelimiter", colors.base0F, colors.none, none)
Group.new("rubyRegexp", colors.base0C, colors.none, none)
Group.new("rubySymbol", colors.base0B, colors.none, none)
Group.new("rubyStringDelimiter", colors.base0B, colors.none, none)

-- SASS Group.newing
Group.new("sassidChar", colors.base08, colors.none, none)
Group.new("sassClassChar", colors.base09, colors.none, none)
Group.new("sassInclude", colors.base0E, colors.none, none)
Group.new("sassMixing", colors.base0E, colors.none, none)
Group.new("sassMixinName", colors.base0D, colors.none, none)

-- Signify Group.newing
Group.new("SignifySignAdd", colors.base0B, colors.base01, none)
Group.new("SignifySignChange", colors.base0D, colors.base01, none)
Group.new("SignifySignDelete", colors.base08, colors.base01, none)

-- Spelling Group.newing
Group.new("SpellBad", colors.none, colors.none, undercurl)
Group.new("SpellLocal", colors.none, colors.none, undercurl)
Group.new("SpellCap", colors.none, colors.none, undercurl)
Group.new("SpellRare", colors.none, colors.none, undercurl)

-- Java Group.newing
Group.new("javaOperator", colors.base0D, colors.none, none)

-- treesitter
Group.new("TSNone", colors.base05, colors.none, none)
Group.new("TSPunctDelimiter", colors.base08, colors.none, none)
Group.new("TSPunctBracket", colors.base08, colors.none, none)
Group.new("TSPunctSpecial", colors.base0F, colors.none, none)
Group.new("TSConstant", colors.base09, colors.none, bold)
Group.new("TSConstBuiltin", colors.base0C, colors.none, none)
Group.new("TSConstMacro", colors.base0E, colors.none, none)
Group.new("TSString", colors.base0B, colors.none, none)
Group.new("TSStringRegex", colors.base0B, colors.none, none)
Group.new("TSStringEscape", colors.base0F, colors.none, none)
Group.new("TSCharacter", colors.base08, colors.none, none)
Group.new("TSNumber", colors.base09, colors.none, none)
Group.new("TSBoolean", colors.base0B, colors.none, bold)
Group.new("TSFloat", colors.base0B, colors.none, none)
Group.new("TSFunction", colors.base0D, colors.none, bold)
Group.new("TSFuncBuiltin", colors.base0C, colors.none, none)
Group.new("TSFuncMacro", colors.base08, colors.none, none)
Group.new("TSParameter", colors.base08, colors.none, none)
Group.new("TSParameterReference", colors.base08, colors.none, none)
Group.new("TSMethod", colors.base0D, colors.none, bold)
Group.new("TSField", colors.base0A, colors.none, none)
Group.new("TSProperty", colors.base08, colors.none, none)
Group.new("TSConstructor", colors.base0C, colors.none, none)
Group.new("TSAnnotation", colors.base0A, colors.none, none)
Group.new("TSAttribute", colors.base0A, colors.none, none)
Group.new("TSNamespace", colors.base0D, colors.none, none)
Group.new("TSConditional", colors.base0E, colors.none, none)
Group.new("TSRepeat", colors.base0D, colors.none, none)
Group.new("TSLabel", colors.base0A, colors.none, none)
Group.new("TSOperator", colors.base07, colors.none, none)
Group.new("TSKeyword", colors.base0E, colors.none, none)
Group.new("TSKeywordFunction", colors.base0E, colors.none, bold)
Group.new("TSKeywordOperator", colors.base08, colors.none, none)
Group.new("TSException", colors.base08, colors.none, none)
Group.new("TSType", colors.base0A, colors.none, bold)
Group.new("TSTypeBuiltin", colors.base0A, colors.none, bold)
Group.new("TSInclude", colors.base0D, colors.none, none)
Group.new("TSVariableBuiltin", colors.base0C, colors.none, none)
Group.new("TSText", colors.base05, colors.base00, none)
Group.new("TSStrong", colors.base07, colors.base00, bold)
Group.new("TSEmphasis", colors.base06, colors.base00, italics)
Group.new("TSUnderline", colors.base05, colors.base00, underline)
Group.new("TSTitle", colors.base0D, colors.none, none)
Group.new("TSLiteral", colors.base0B, colors.none, none)
Group.new("TSURI", colors.base08, colors.none, none)
Group.new("TSTag", colors.base0A, colors.none, none)
Group.new("TSTagDelimiter", colors.base0F, colors.none, none)
Group.new("TSDefinitionUsage", colors.none, colors.base02, none)
Group.new("TSDefinition", colors.base01, colors.base0A, none)
Group.new("TSCurrentScope", colors.none, colors.base01, none)

-- LSP
Group.new("DiagnosticError", colors.red, colors.none, none)
Group.new("DiagnosticWarn", colors.yellow, colors.none, none)
Group.new("DiagnosticInfo", colors.blue, colors.none, none)
Group.new("DiagnosticHint", colors.purple, colors.none, none)
Group.new("DiagnosticVirtualTextError", colors.red, colors.none, none)
Group.new("DiagnosticVirtualTextWarn", colors.yellow, colors.none, none)
Group.new("DiagnosticVirtualTextInfo", colors.blue, colors.none, none)
Group.new("DiagnosticVirtualTextHint", colors.purple, colors.none, none)
Group.new("DiagnosticUnderlineError", colors.red, colors.none, underline)
Group.new("DiagnosticUnderlineWarn", colors.yellow, colors.none, underline)
Group.new("DiagnosticUnderlineInfo", colors.blue, colors.none, underline)
Group.new("DiagnosticUnderlineHint", colors.purple, colors.none, underline)
Group.new("DiagnosticFloatingError", colors.red, groups.pmenu, underline)
Group.new("DiagnosticFloatingWarn", colors.yellow, groups.pmenu, underline)
Group.new("DiagnosticFloatingInfo", colors.blue, groups.pmenu, underline)
Group.new("DiagnosticFloatingHint", colors.purple, groups.pmenu, underline)
Group.new("DiagnosticSignError", colors.red, colors.none, none)
Group.new("DiagnosticSignWarn", colors.yellow, colors.none, none)
Group.new("DiagnosticSignInfo", colors.blue, colors.none, none)
Group.new("DiagnosticSignHint", colors.purple, colors.none, none)

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
Group.new("IndentBlanklineChar", colors.line, colors.none, none)
Group.new("IndentBlanklineContextChar", colors.base0E, colors.none, none)
Group.new("IndentBlanklineContextStart", colors.none, colors.none, none)

-- misc
Group.new("NvimInternalError", colors.red, colors.none, none)
Group.new("EndOfBuffer", colors.black, colors.none, none)
Group.new("StatusLineNC", colors.line, colors.none, underline)

-- telescope
Group.new("TelescopeBorder", colors.lightbg, colors.none, none)
Group.new("TelescopePromptBorder", colors.lightbg, colors.none, none)
Group.new("TelescopeResultsBorder", colors.lightbg, colors.none, none)
Group.new("TelescopePreviewBorder", colors.lightbg, colors.none, none)
Group.new("TelescopePreviewLine", colors.none, colors.line, none)
Group.new("TelescopeSelection", colors.none, colors.line, none)

-- symbols-outline
Group.new("FocusedSymbol", colors.base08, colors.line, none)
