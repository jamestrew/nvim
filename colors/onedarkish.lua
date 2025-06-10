local onedark = require("themes.onedark")
local Color, colors, Group, groups, styles = require("colorbuddy").setup()
local v = vim



for name, hex in pairs(onedark.colors) do
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
Group.new("Italic", colors.none, colors.none, styles.italic)
Group.new("Macro", colors.base08, colors.none, styles.NONE)
Group.new("MatchParen", colors.none, colors.base03, styles.NONE)
Group.new("ModeMsg", colors.base0B, colors.none, styles.NONE)
Group.new("MoreMsg", colors.base0B, colors.none, styles.NONE)
Group.new("Question", colors.base0D, colors.none, styles.NONE)
Group.new("Search", colors.base01, colors.base0A, styles.NONE)
Group.new("IncSearch", colors.base01, colors.base09, styles.NONE)
Group.new("CurSearch", colors.base01, colors.base0E, styles.NONE)
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
Group.new("NormalFloat", colors.base05, colors.one_bg, styles.NONE)
Group.new("PMenu", colors.base05, colors.one_bg, styles.NONE)
Group.new("PMenuSel", colors.base01, colors.green, styles.NONE)
Group.new("PmenuSbar", colors.none, colors.one_bg2, styles.NONE)
Group.new("PmenuThumb", colors.none, colors.nord_blue, styles.NONE)
Group.new("PmenuExtra", colors.grey_fg2)
Group.new("TabLineFill", colors.base03, colors.base01, styles.NONE)
Group.new("TabLineSel", colors.base0B, colors.base01, styles.NONE)
Group.new("WinBar", colors.base05, colors.lightbg, styles.NONE)
Group.new("WinBarNC", colors.base04, colors.black, styles.NONE)

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

-- Neogit
Group.new("NeogitDiffAddHighlight", colors.base0B, diff_bg(colors.base0B), styles.NONE)
Group.new("NeogitDiffAdd", colors.base0B, diff_bg(colors.base0B), styles.NONE)
Group.new("NeogitDiffDeleteHighlight", colors.base08, diff_bg(colors.base08), styles.NONE)
Group.new("NeogitDiffDelete", colors.base08, diff_bg(colors.base08), styles.NONE)
Group.new("NeogitDiffContextHighlight", colors.none, colors.lightbg, styles.NONE)
Group.new("NeogitHunkHeaderHighlight", colors.base00, colors.nord_blue, styles.bold)

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
Group.new("@variable", colors.none, colors.none, styles.NONE)
Group.new("@variable.builtin", colors.base0C, colors.none, styles.NONE)
Group.new("@variable.parameter", colors.base08, colors.none, styles.NONE)
Group.new("@variable.member", colors.base0A, colors.none, styles.NONE)

Group.new("@constant", colors.base09, colors.none, styles.bold)
Group.new("@constant.builtin", colors.base0C, colors.none, styles.NONE)
Group.new("@constant.macro", colors.base0E, colors.none, styles.NONE)

Group.new("@module", colors.base0D, colors.none, styles.NONE)
-- Group.new("@module.builtin", colors.base0D, colors.none, styles.NONE)
Group.new("@label", colors.base0A, colors.none, styles.NONE)

Group.new("@string", colors.base0B, colors.none, styles.NONE)
-- Group.new("@string.documentation", colors.base0B, colors.none, styles.NONE)
Group.new("@string.regexp", colors.base0B, colors.none, styles.NONE)
Group.new("@string.escape", colors.base0F, colors.none, styles.NONE)
-- Group.new("@string.special", colors.base0F, colors.none, styles.NONE) -- other special strings (eg dates)
-- Group.new("@string.special.symbol", colors.base0F, colors.none, styles.NONE) -- symbols or atoms
-- Group.new("@string.special.url", colors.base0F, colors.none, styles.NONE)
-- Group.new("@string.special.path", colors.base0F, colors.none, styles.NONE)

Group.new("@character", colors.base08, colors.none, styles.NONE)
-- Group.new("@character.special", colors.base08, colors.none, styles.NONE) -- eg. wildcard

Group.new("@boolean", colors.base0C, colors.none, styles.bold)
Group.new("@number", colors.base09, colors.none, styles.NONE)
Group.new("@number.float", colors.base09, colors.none, styles.NONE)

Group.new("@type", colors.base0A, colors.none, styles.bold)
Group.new("@type.builtin", colors.base0A, colors.none, styles.bold)
-- Group.new("@type.definition", colors.base0A, colors.none, styles.bold) -- identifiers in type defs
-- Group.new("@type.qualifier", colors.base0A, colors.none, styles.bold) -- eg `const`

Group.new("@attribute", colors.base0A, colors.none, styles.NONE)
Group.new("@property", colors.base0A, colors.none, styles.NONE)

Group.new("@function", colors.base0D, colors.none, styles.bold)
Group.new("@function.builtin", colors.base0C, colors.none, styles.NONE)
-- Group.new("@function.call", colors.base0C, colors.none, styles.NONE)
Group.new("@function.macro", colors.base0D, colors.none, styles.NONE)
Group.new("@function.method", colors.base0D, colors.none, styles.bold)
-- Group.new("@function.method.call", colors.base0D, colors.none, styles.bold)

Group.new("@constructor", colors.base0C, colors.none, styles.NONE)
Group.new("@operator", colors.base07, colors.none, styles.NONE)

Group.new("@keyword", colors.base0E, colors.none, styles.NONE)
-- Group.new("@keyword.coroutine", colors.base0E, colors.none, styles.NONE) -- eg. `go` in GO, `async/await`
Group.new("@keyword.function", colors.base0E, colors.none, styles.bold)
Group.new("@keyword.operator", colors.base08, colors.none, styles.NONE) -- operators in english `and`/`or`
Group.new("@keyword.import", colors.base0D, colors.none, styles.NONE)
Group.new("@keyword.storage", colors.base0E, colors.none, styles.NONE) -- modifiers that affect storage in memory or life-time
Group.new("@keyword.repeat", colors.base0D, colors.none, styles.NONE) -- loop stuff `for`/`while`
-- Group.new("@keyword.return", colors.base0E, colors.none, styles.NONE)
Group.new("@keyword.debug", colors.base0E, colors.none, styles.NONE)
Group.new("@keyword.exception", colors.base08, colors.none, styles.NONE) -- `throw`/`catch`

Group.new("@keyword.conditional", colors.base0E, colors.none, styles.NONE)
-- Group.new("@keyword.conditional.ternary", colors.base0E, colors.none, styles.NONE)

-- Group.new("@keyword.directive", colors.base0E, colors.none, styles.NONE)
-- Group.new("@keyword.directive.define", colors.base0E, colors.none, styles.NONE)

Group.new("@punctuation", colors.base0F, colors.none, styles.NONE)
-- Group.new("@punctuation.delimiter", colors.base08, colors.none, styles.NONE) -- eg `;`, `,`, `.`
-- Group.new("@punctuation.bracket", colors.base08, colors.none, styles.NONE) -- eg `()`, `{}`, `[]`
-- Group.new("@punctuation.special", colors.base08, colors.none, styles.NONE) -- eg `{}` in string interpolation

Group.new("@comment", colors.grey_fg2, colors.none, styles.NONE)
-- Group.new("@comment.documentation", colors.grey_fg2, colors.none, styles.NONE)
-- Group.new("@comment.error", colors.grey_fg2, colors.none, styles.NONE)
-- Group.new("@comment.warning", colors.grey_fg2, colors.none, styles.NONE)
-- Group.new("@comment.hint", colors.grey_fg2, colors.none, styles.NONE)
-- Group.new("@comment.info", colors.grey_fg2, colors.none, styles.NONE)
-- Group.new("@comment.todo", colors.grey_fg2, colors.none, styles.NONE)

Group.new("@markup", colors.base05, colors.none, styles.NONE)
Group.new("@markup.italic", colors.base06, colors.none, styles.italic)
Group.new("@markup.strikethrough", colors.base05, colors.none, styles.strikethrough)
Group.new("@markup.strong", colors.base07, colors.none, styles.bold)
Group.new("@markup.underline", colors.base05, colors.none, styles.underline)
Group.new("@markup.heading", colors.base0D, colors.none, styles.NONE)

-- Group.new("@markup.quote", colors.base05, colors.none, styles.NONE)
-- Group.new("@markup.math", colors.base05, colors.none, styles.NONE)
-- Group.new("@markup.environment", colors.base05, colors.none, styles.NONE)
-- Group.new("@markup.link", colors.base05, colors.none, styles.NONE)
-- Group.new("@markup.link.label", colors.base05, colors.none, styles.NONE)
-- Group.new("@markup.link.url", colors.base05, colors.none, styles.NONE)

Group.new("@markup.raw", colors.grey_fg2, colors.none, styles.NONE)
-- Group.new("@markup.raw.block", colors.base05, colors.none, styles.NONE)

Group.new("@markup.list", colors.base0F, colors.none, styles.NONE)
-- Group.new("@markup.list.checked", colors.base0F, colors.none, styles.NONE)
-- Group.new("@markup.list.unchecked", colors.base0F, colors.none, styles.NONE)

Group.new("@diff.plus", colors.none, groups["DiffAdd"], styles.NONE)
Group.new("@diff.minus", colors.none, groups["DiffDelete"], styles.NONE)
Group.new("@diff.delta", colors.none, groups["DiffChange"], styles.NONE)

Group.new("@tag", colors.base0A, colors.none, styles.NONE)
-- Group.new("@tag.attribute", colors.base0A, colors.none, styles.NONE)
Group.new("@tag.delimiter", colors.base0F, colors.none, styles.NONE)

-- Semantic Tokens
Group.new("@lsp.type.namespace", groups["@module"], groups["@module"], groups["@module"])
Group.new("@lsp.type.type", groups["@type"], groups["@type"], groups["@type"])
Group.new("@lsp.type.class", groups["@type"], groups["@type"], groups["@type"])
Group.new("@lsp.type.struct", groups["@type"], groups["@type"], groups["@type"])
Group.new("@lsp.type.enum", groups["@type"], groups["@type"], groups["@type"])
Group.new("@lsp.type.interface", groups["@type"], groups["@type"], groups["@type"])
Group.new(
  "@lsp.type.parameter",
  groups["@variable.parameter"],
  groups["@variable.parameter"],
  groups["@variable.parameter"]
)
Group.new("@lsp.type.variable", groups["@variable"], groups["@variable"], groups["@variable"])
Group.new(
  "@lsp.type.property",
  groups["@variable.member"],
  groups["@variable.member"],
  groups["@variable.member"]
)
Group.new("@lsp.type.enumMember", groups["@constant"], groups["@constant"], groups["@constant"])
Group.new("@lsp.type.function", groups["@function"], groups["@function"], groups["@function"])
Group.new("@lsp.type.decorator", groups["@function"], groups["@function"], groups["@function"])
Group.new(
  "@lsp.type.method",
  groups["@function.method"],
  groups["@function.method"],
  groups["@function.method"]
)
Group.new(
  "@lsp.type.macro",
  groups["@function.macro"],
  groups["@function.macro"],
  groups["@function.macro"]
)

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
Group.new("DiagnosticFloatingError", colors.red, colors.none, styles.underline)
Group.new("DiagnosticFloatingWarn", colors.yellow, colors.none, styles.underline)
Group.new("DiagnosticFloatingInfo", colors.blue, colors.none, styles.underline)
Group.new("DiagnosticFloatingHint", colors.purple, colors.none, styles.underline)
Group.new("DiagnosticSignError", colors.red, colors.none, styles.NONE)
Group.new("DiagnosticSignWarn", colors.yellow, colors.none, styles.NONE)
Group.new("DiagnosticSignInfo", colors.blue, colors.none, styles.NONE)
Group.new("DiagnosticSignHint", colors.purple, colors.none, styles.NONE)

Group.new("LspInlayHint", colors.grey_fg2, colors.lightbg, styles.NONE)

-- Terminal
v.g.terminal_color_0 = onedark.base00
v.g.terminal_color_1 = onedark.base08
v.g.terminal_color_2 = onedark.base0B
v.g.terminal_color_3 = onedark.base0A
v.g.terminal_color_4 = onedark.base0D
v.g.terminal_color_5 = onedark.base0E
v.g.terminal_color_6 = onedark.base0C
v.g.terminal_color_7 = onedark.base05
v.g.terminal_color_8 = onedark.base03
v.g.terminal_color_9 = onedark.base08
v.g.terminal_color_10 = onedark.base0B
v.g.terminal_color_11 = onedark.base0A
v.g.terminal_color_12 = onedark.base0D
v.g.terminal_color_13 = onedark.base0E
v.g.terminal_color_14 = onedark.base0C
v.g.terminal_color_15 = onedark.base07

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
-- Group.new("MatchParen", colors.none, colors.grey, styles.NONE)

-- DAP
Group.new("DapBreakpoint", colors.base08, colors.none, styles.NONE)

Group.new("BufferLineFill", colors.none, colors.statusline_bg)

-- Blink
Group.new("BlinkCmpKindConstant", colors.base09)
Group.new("BlinkCmpKindFunction", colors.base0D)
Group.new("BlinkCmpKindIdentifier", colors.base08)
Group.new("BlinkCmpKindField", colors.base08)
Group.new("BlinkCmpKindVariable", colors.base0E)
Group.new("BlinkCmpKindSnippet", colors.red)
Group.new("BlinkCmpKindText", colors.base0B)
Group.new("BlinkCmpKindStructure", colors.base0E)
Group.new("BlinkCmpKindType", colors.base0A)
Group.new("BlinkCmpKindKeyword", colors.base07)
Group.new("BlinkCmpKindMethod", colors.base0D)
Group.new("BlinkCmpKindConstructor", colors.blue)
Group.new("BlinkCmpKindFolder", colors.base07)
Group.new("BlinkCmpKindModule", colors.base0A)
Group.new("BlinkCmpKindProperty", colors.base08)
Group.new("BlinkCmpKindUnit", colors.base0E)
Group.new("BlinkCmpKindFile", colors.base07)
Group.new("BlinkCmpKindColor", colors.red)
Group.new("BlinkCmpKindReference", colors.base05)
Group.new("BlinkCmpKindStruct", colors.base0E)
Group.new("BlinkCmpKindOperator", colors.base05)
Group.new("BlinkCmpKindTypeParameter", colors.base08)
Group.new("BlinkCmpKindCopilot", colors.green)
Group.new("BlinkCmpKindClass", colors.base0A)

Group.new("IlluminatedWordText", groups.CursorLine, groups.CursorLine, groups.CursorLine)
Group.new("IlluminatedWordRead", groups.CursorLine, groups.CursorLine, groups.CursorLine)
Group.new("IlluminatedWordWrite", groups.CursorLine, groups.CursorLine, groups.CursorLine)
