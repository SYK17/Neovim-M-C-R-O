-- Name:         cockatoo
-- Description:  Soft but colorful colorscheme with light and dark variants
-- Author:       Bekaboo <kankefengjing@gmail.com>
-- Maintainer:   Bekaboo <kankefengjing@gmail.com>
-- License:      GPL-3.0
-- Last Updated: Mon Jul  3 03:21:21 PM CDT 2023

-- Palette {{{
-- stylua: ignore start
local palette_variants = {
  dark = {
    yellow         = '#e6bb86',
    earth          = '#c1a575',
    orange         = '#f0a16c',
    pink           = '#f49ba7',
    ochre          = '#e87c69',
    scarlet        = '#d85959',
    wine           = '#a52929',
    tea            = '#a4bd84',
    aqua           = '#79ada7',
    turquoise      = '#7fa0af',
    flashlight     = '#add0ef',
    skyblue        = '#a5d5ff',
    cerulean       = '#86aadc',
    lavender       = '#caafeb',
    purple         = '#a48fd1',
    magenta        = '#dc8ed3',
    pigeon         = '#8f9fbc',
    cumulonimbus   = '#557396',
    thunder        = '#425974',
    white          = '#e5e5eb',
    smoke          = '#bebec3',
    beige          = '#b1aca7',
    steel          = '#606d86',
    iron           = '#313742',
    deepsea        = '#334154',
    ocean          = '#303846',
    jeans          = '#262a34',
    space          = '#13161f',
    black          = '#09080b',
    shadow         = '#09080b',
    tea_blend      = '#425858',
    aqua_blend     = '#2f3f48',
    purple_blend   = '#33374b',
    lavender_blend = '#4b4b6e',
    scarlet_blend  = '#4b323c',
    wine_blend     = '#35262d',
    earth_blend    = '#303032',
    smoke_blend    = '#272d3a',
    pigeon_blend   = '#27323c',
  },
  light = {
    yellow         = '#c88500',
    earth          = '#b48327',
    orange         = '#a84a24',
    pink           = '#df6d73',
    ochre          = '#c84b2b',
    scarlet        = '#d85959',
    wine           = '#a52929',
    tea            = '#5f8c3f',
    aqua           = '#3b8f84',
    turquoise      = '#29647a',
    flashlight     = '#76a2c2',
    skyblue        = '#4c99d4',
    cerulean       = '#3c70b4',
    lavender       = '#9d7bca',
    purple         = '#8b71c7',
    magenta        = '#ac4ea1',
    pigeon         = '#6666a8',
    cumulonimbus   = '#486a91',
    thunder        = '#dfd6ce',
    white          = '#385372',
    smoke          = '#404553',
    beige          = '#385372',
    steel          = '#9a978a',
    iron           = '#b8b7b3',
    deepsea        = '#e6ded6',
    ocean          = '#f0e8e2',
    jeans          = '#faf4ed',
    space          = '#faf7ee',
    black          = '#efefef',
    shadow         = '#3c3935',
    tea_blend      = '#bdc8ad',
    aqua_blend     = '#c4cdc2',
    purple_blend   = '#e1dbe2',
    lavender_blend = '#bcb0cd',
    scarlet_blend  = '#e6b8b3',
    wine_blend     = '#e6c9c3',
    earth_blend    = '#ebe0ce',
    smoke_blend    = '#e4e4e2',
    pigeon_blend   = '#f4eee8',
  },
}
-- stylua: ignore end
local palette = palette_variants[vim.go.bg]
-- }}}

-- Terminal colors {{{
local termcolor_variants = {
  dark = {
    terminal_color_0 = palette.ocean,
    terminal_color_8 = palette.white,
    terminal_color_1 = palette.ochre,
    terminal_color_9 = palette.ochre,
    terminal_color_2 = palette.tea,
    terminal_color_10 = palette.tea,
    terminal_color_3 = palette.yellow,
    terminal_color_11 = palette.yellow,
    terminal_color_4 = palette.cumulonimbus,
    terminal_color_12 = palette.cumulonimbus,
    terminal_color_5 = palette.lavender,
    terminal_color_13 = palette.lavender,
    terminal_color_6 = palette.aqua,
    terminal_color_14 = palette.aqua,
    terminal_color_7 = palette.white,
    terminal_color_15 = palette.pigeon,
  },
  light = {
    terminal_color_0 = palette.ocean,
    terminal_color_8 = palette.white,
    terminal_color_1 = palette.ochre,
    terminal_color_9 = palette.ochre,
    terminal_color_2 = palette.tea,
    terminal_color_10 = palette.tea,
    terminal_color_3 = palette.yellow,
    terminal_color_11 = palette.yellow,
    terminal_color_4 = palette.flashlight,
    terminal_color_12 = palette.cumulonimbus,
    terminal_color_5 = palette.lavender,
    terminal_color_13 = palette.lavender,
    terminal_color_6 = palette.aqua,
    terminal_color_14 = palette.aqua,
    terminal_color_7 = palette.white,
    terminal_color_15 = palette.pigeon,
  },
}
local termcolors = termcolor_variants[vim.go.bg]
-- }}}

-- Highlight groups {{{1
local hlgroups = {
  -- Common {{{2
  Normal = { fg = palette.smoke, bg = palette.jeans },
  NormalFloat = { fg = palette.smoke, bg = palette.ocean },
  NormalNC = { link = 'Normal' },
  ColorColumn = { bg = palette.deepsea },
  Conceal = { fg = palette.smoke },
  Cursor = { fg = palette.space, bg = palette.white },
  CursorColumn = { bg = palette.ocean },
  CursorIM = { fg = palette.space, bg = palette.flashlight },
  CursorLine = { bg = palette.ocean },
  CursorLineNr = { fg = palette.orange, bold = true },
  DebugPC = { bg = palette.purple_blend },
  lCursor = { link = 'Cursor' },
  TermCursor = { fg = palette.space, bg = palette.orange },
  TermCursorNC = { fg = palette.orange, bg = palette.ocean },
  DiffAdd = { bg = palette.aqua_blend },
  DiffAdded = { fg = palette.tea, bg = palette.aqua_blend },
  DiffChange = { bg = palette.purple_blend },
  DiffDelete = { fg = palette.wine, bg = palette.wine_blend },
  DiffRemoved = { fg = palette.scarlet, bg = palette.wine_blend },
  DiffText = { bg = palette.lavender_blend },
  Directory = { fg = palette.pigeon },
  EndOfBuffer = { fg = palette.iron },
  ErrorMsg = { fg = palette.scarlet },
  FoldColumn = { fg = palette.steel },
  Folded = { fg = palette.steel, bg = palette.ocean },
  FloatBorder = { fg = palette.smoke, bg = palette.ocean },
  FloatShadow = { bg = palette.shadow, blend = 70 },
  FloatShadowThrough = { link = 'None' },
  HealthSuccess = { fg = palette.tea },
  Search = { bg = palette.thunder },
  IncSearch = { fg = palette.black, bg = palette.orange, bold = true },
  CurSearch = { link = 'IncSearch' },
  LineNr = { fg = palette.steel },
  ModeMsg = { fg = palette.smoke },
  MoreMsg = { fg = palette.aqua },
  MsgArea = { link = 'Normal' },
  MsgSeparator = { link = 'StatusLine' },
  MatchParen = { bg = palette.thunder, bold = true },
  NonText = { fg = palette.iron },
  Pmenu = { fg = palette.smoke, bg = palette.ocean },
  PmenuSbar = { bg = palette.deepsea },
  PmenuSel = { fg = palette.white, bg = palette.thunder },
  PmenuThumb = { bg = palette.orange },
  Question = { fg = palette.smoke },
  QuickFixLine = { link = 'Visual' },
  SignColumn = { fg = palette.smoke },
  SpecialKey = { fg = palette.orange },
  SpellBad = { underdashed = true },
  SpellCap = { link = 'SpellBad' },
  SpellLocal = { link = 'SpellBad' },
  SpellRare = { link = 'SpellBad' },
  StatusLine = { fg = palette.smoke, bg = palette.deepsea },
  StatusLineNC = { fg = palette.steel, bg = palette.ocean },
  Substitute = { link = 'Search' },
  TabLine = { link = 'StatusLine' },
  TabLineFill = { fg = palette.pigeon, bg = palette.ocean },
  Title = { fg = palette.pigeon, bold = true },
  VertSplit = { fg = palette.deepsea },
  Visual = { bg = palette.deepsea },
  VisualNOS = { link = 'Visual' },
  WarningMsg = { fg = palette.yellow },
  Whitespace = { link = 'NonText' },
  WildMenu = { link = 'PmenuSel' },
  Winseparator = { link = 'VertSplit' },
  WinBar = { fg = palette.smoke },
  WinBarNC = { fg = palette.pigeon },
  -- }}}2

  -- Syntax {{{2
  Comment = { fg = palette.steel, italic = true },
  Constant = { fg = palette.ochre },
  String = { fg = palette.turquoise },
  DocumentKeyword = { fg = palette.tea },
  Character = { fg = palette.orange },
  Number = { fg = palette.purple },
  Boolean = { fg = palette.ochre },
  Array = { fg = palette.orange },
  Float = { link = 'Number' },
  Identifier = { fg = palette.smoke },
  Builtin = { fg = palette.pink, italic = true },
  Field = { fg = palette.pigeon },
  Enum = { fg = palette.ochre },
  Namespace = { fg = palette.ochre },
  Function = { fg = palette.yellow },
  Statement = { fg = palette.lavender },
  Specifier = { fg = palette.lavender },
  Object = { fg = palette.lavender },
  Conditional = { fg = palette.magenta },
  Repeat = { fg = palette.magenta },
  Label = { fg = palette.magenta },
  Operator = { fg = palette.orange },
  Keyword = { fg = palette.cerulean },
  Exception = { fg = palette.magenta },
  PreProc = { fg = palette.turquoise },
  PreCondit = { link = 'PreProc' },
  Include = { link = 'PreProc' },
  Define = { link = 'PreProc' },
  Macro = { fg = palette.ochre },
  Type = { fg = palette.lavender },
  StorageClass = { link = 'Keyword' },
  Structure = { link = 'Type' },
  Typedef = { fg = palette.beige },
  Special = { fg = palette.orange },
  SpecialChar = { link = 'Special' },
  Tag = { fg = palette.flashlight, underline = true },
  Delimiter = { fg = palette.orange },
  Bracket = { fg = palette.cumulonimbus },
  SpecialComment = { link = 'SpecialChar' },
  Debug = { link = 'Special' },
  Underlined = { underline = true },
  Ignore = { fg = palette.iron },
  Error = { fg = palette.scarlet },
  Todo = { fg = palette.black, bg = palette.beige, bold = true },
  -- }}}2

  -- Treesitter syntax {{{2
  ['@field'] = { link = 'Field' },
  ['@property'] = { link = 'Field' },
  ['@annotation'] = { link = 'Operator' },
  ['@comment'] = { link = 'Comment' },
  ['@none'] = { link = 'None' },
  ['@preproc'] = { link = 'PreProc' },
  ['@define'] = { link = 'Define' },
  ['@operator'] = { link = 'Operator' },
  ['@punctuation.delimiter'] = { link = 'Delimiter' },
  ['@punctuation.bracket'] = { link = 'Bracket' },
  ['@punctuation.special'] = { link = 'Delimiter' },
  ['@string'] = { link = 'String' },
  ['@string.regex'] = { link = 'String' },
  ['@string.escape'] = { link = 'SpecialChar' },
  ['@string.special'] = { link = 'SpecialChar' },
  ['@character'] = { link = 'Character' },
  ['@character.special'] = { link = 'SpecialChar' },
  ['@boolean'] = { link = 'Boolean' },
  ['@number'] = { link = 'Number' },
  ['@float'] = { link = 'Float' },
  ['@function'] = { link = 'Function' },
  ['@function.call'] = { link = 'Function' },
  ['@function.builtin'] = { link = 'Special' },
  ['@function.macro'] = { link = 'Macro' },
  ['@method'] = { link = 'Function' },
  ['@method.call'] = { link = 'Function' },
  ['@constructor'] = { link = 'Function' },
  ['@parameter'] = { link = 'Parameter' },
  ['@keyword'] = { link = 'Keyword' },
  ['@keyword.function'] = { link = 'Keyword' },
  ['@keyword.return'] = { link = 'Keyword' },
  ['@conditional'] = { link = 'Conditional' },
  ['@repeat'] = { link = 'Repeat' },
  ['@debug'] = { link = 'Debug' },
  ['@label'] = { link = 'Keyword' },
  ['@include'] = { link = 'Include' },
  ['@exception'] = { link = 'Exception' },
  ['@type'] = { link = 'Type' },
  ['@type.Builtin'] = { link = 'Type' },
  ['@type.qualifier'] = { link = 'Type' },
  ['@type.definition'] = { link = 'Typedef' },
  ['@storageclass'] = { link = 'StorageClass' },
  ['@attribute'] = { link = 'Label' },
  ['@variable'] = { link = 'Identifier' },
  ['@variable.Builtin'] = { link = 'Builtin' },
  ['@constant'] = { link = 'Constant' },
  ['@constant.Builtin'] = { link = 'Constant' },
  ['@constant.macro'] = { link = 'Macro' },
  ['@namespace'] = { link = 'Namespace' },
  ['@symbol'] = { link = 'Identifier' },
  ['@text'] = { link = 'String' },
  ['@text.title'] = { link = 'Title' },
  ['@text.literal'] = { link = 'String' },
  ['@text.uri'] = { link = 'htmlLink' },
  ['@text.math'] = { link = 'Special' },
  ['@text.environment'] = { link = 'Macro' },
  ['@text.environment.name'] = { link = 'Type' },
  ['@text.reference'] = { link = 'Constant' },
  ['@text.todo'] = { link = 'Todo' },
  ['@text.todo.unchecked'] = { link = 'Todo' },
  ['@text.todo.checked'] = { link = 'Done' },
  ['@text.note'] = { link = 'SpecialComment' },
  ['@text.warning'] = { link = 'WarningMsg' },
  ['@text.danger'] = { link = 'ErrorMsg' },
  ['@text.diff.add'] = { link = 'DiffAdded' },
  ['@text.diff.delete'] = { link = 'DiffRemoved' },
  ['@tag'] = { link = 'Tag' },
  ['@tag.attribute'] = { link = 'Identifier' },
  ['@tag.delimiter'] = { link = 'Delimiter' },
  ['@text.strong'] = { bold = true },
  ['@text.strike'] = { strikethrough = true },
  ['@text.emphasis'] = {
    fg = palette.black,
    bg = palette.beige,
    bold = true,
    italic = true,
  },
  ['@text.underline'] = { underline = true },
  ['@keyword.operator'] = { link = 'Operator' },
  -- }}}2

  -- LSP semantic {{{2
  ['@lsp.type.enum'] = { link = 'Type' },
  ['@lsp.type.type'] = { link = 'Type' },
  ['@lsp.type.class'] = { link = 'Structure' },
  ['@lsp.type.struct'] = { link = 'Structure' },
  ['@lsp.type.macro'] = { link = 'Macro' },
  ['@lsp.type.method'] = { link = 'Function' },
  ['@lsp.type.comment'] = { link = 'Comment' },
  ['@lsp.type.function'] = { link = 'Function' },
  ['@lsp.type.property'] = { link = 'Field' },
  ['@lsp.type.variable'] = { link = 'Variable' },
  ['@lsp.type.decorator'] = { link = 'Label' },
  ['@lsp.type.interface'] = { link = 'Structure' },
  ['@lsp.type.namespace'] = { link = 'Namespace' },
  ['@lsp.type.parameter'] = { link = 'Parameter' },
  ['@lsp.type.enumMember'] = { link = 'Enum' },
  ['@lsp.type.typeParameter'] = { link = 'Parameter' },
  ['@lsp.typemod.keyword.documentation'] = { link = 'DocumentKeyword' },
  ['@lsp.typemod.function.defaultLibrary'] = { link = 'Special' },
  ['@lsp.typemod.variable.defaultLibrary'] = { link = 'Builtin' },
  ['@lsp.typemod.variable.global'] = { link = 'Identifier' },
  -- }}}2

  -- LSP {{{2
  LspReferenceText = { link = 'Identifier' },
  LspReferenceRead = { link = 'LspReferenceText' },
  LspReferenceWrite = { link = 'LspReferenceText' },
  LspSignatureActiveParameter = { link = 'IncSearch' },
  LspInfoBorder = { link = 'FloatBorder' },
  LspInlayHint = { link = 'DiagnosticVirtualTextHint' },
  -- }}}2

  -- Diagnostic {{{2
  DiagnosticOk = { fg = palette.tea },
  DiagnosticError = { fg = palette.wine },
  DiagnosticWarn = { fg = palette.earth },
  DiagnosticInfo = { fg = palette.smoke },
  DiagnosticHint = { fg = palette.pigeon },
  DiagnosticVirtualTextOk = { fg = palette.tea, bg = palette.tea_blend },
  DiagnosticVirtualTextError = { fg = palette.wine, bg = palette.wine_blend },
  DiagnosticVirtualTextWarn = { fg = palette.earth, bg = palette.earth_blend },
  DiagnosticVirtualTextInfo = { fg = palette.smoke, bg = palette.smoke_blend },
  DiagnosticVirtualTextHint = { fg = palette.pigeon, bg = palette.deepsea },
  DiagnosticUnderlineOk = { underline = true, sp = palette.tea },
  DiagnosticUnderlineError = { undercurl = true, sp = palette.wine },
  DiagnosticUnderlineWarn = { undercurl = true, sp = palette.earth },
  DiagnosticUnderlineInfo = { undercurl = true, sp = palette.flashlight },
  DiagnosticUnderlineHint = { undercurl = true, sp = palette.pigeon },
  DiagnosticFloatingOk = { link = 'DiagnosticOk' },
  DiagnosticFloatingError = { link = 'DiagnosticError' },
  DiagnosticFloatingWarn = { link = 'DiagnosticWarn' },
  DiagnosticFloatingInfo = { link = 'DiagnosticInfo' },
  DiagnosticFloatingHint = { link = 'DiagnosticHint' },
  DiagnosticSignOk = { link = 'DiagnosticOk' },
  DiagnosticSignError = { link = 'DiagnosticError' },
  DiagnosticSignWarn = { link = 'DiagnosticWarn' },
  DiagnosticSignInfo = { link = 'DiagnosticInfo' },
  DiagnosticSignHint = { link = 'DiagnosticHint' },
  DiagnosticSignOkCul = { fg = palette.tea },
  DiagnosticSignErrorCul = { fg = palette.wine },
  DiagnosticSignWarnCul = { fg = palette.earch },
  DiagnosticSignInfoCul = { fg = palette.smoke },
  DiagnosticSignHintCul = { fg = palette.pigeon },
  -- }}}2

  -- Filetype {{{2
  -- HTML
  htmlArg = { fg = palette.pigeon },
  htmlBold = { bold = true },
  htmlBoldItalic = { bold = true, italic = true },
  htmlTag = { fg = palette.smoke },
  htmlTagName = { link = 'Tag' },
  htmlSpecialTagName = { fg = palette.yellow },
  htmlEndTag = { fg = palette.yellow },
  htmlH1 = { fg = palette.yellow, bold = true },
  htmlH2 = { fg = palette.ochre, bold = true },
  htmlH3 = { fg = palette.pink, bold = true },
  htmlH4 = { fg = palette.lavender, bold = true },
  htmlH5 = { fg = palette.cerulean, bold = true },
  htmlH6 = { fg = palette.aqua, bold = true },
  htmlItalic = { italic = true },
  htmlLink = { fg = palette.flashlight, underline = true },
  htmlSpecialChar = { fg = palette.beige },
  htmlTitle = { fg = palette.pigeon },
  -- Json
  jsonKeyword = { link = 'Keyword' },
  jsonBraces = { fg = palette.smoke },
  -- Markdown
  markdownBold = { fg = palette.aqua, bold = true },
  markdownBoldItalic = { fg = palette.skyblue, bold = true, italic = true },
  markdownCode = { fg = palette.pigeon },
  markdownError = { link = 'None' },
  markdownEscape = { link = 'None' },
  markdownListMarker = { fg = palette.orange },
  markdownH1 = { link = 'htmlH1' },
  markdownH2 = { link = 'htmlH2' },
  markdownH3 = { link = 'htmlH3' },
  markdownH4 = { link = 'htmlH4' },
  markdownH5 = { link = 'htmlH5' },
  markdownH6 = { link = 'htmlH6' },
  -- Shell
  shDeref = { link = 'Macro' },
  shDerefVar = { link = 'Macro' },
  -- Git
  gitHash = { fg = palette.pigeon },
  -- Checkhealth
  helpHeader = { fg = palette.pigeon, bold = true },
  helpSectionDelim = { fg = palette.ochre, bold = true },
  helpCommand = { fg = palette.turquoise },
  helpBacktick = { fg = palette.turquoise },
  -- Man
  manBold = { fg = palette.ochre, bold = true },
  manItalic = { fg = palette.turquoise, italic = true },
  manOptionDesc = { fg = palette.ochre },
  manReference = { link = 'htmlLink' },
  manSectionHeading = { link = 'manBold' },
  manUnderline = { fg = palette.cerulean, italic = true },
  -- }}}2

  -- Plugins {{{2
  -- nvim-cmp
  CmpItemAbbr = { fg = palette.smoke },
  CmpItemAbbrDeprecated = { strikethrough = true },
  CmpItemAbbrMatch = { fg = palette.white, bold = true },
  CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
  CmpItemKindText = { link = 'String' },
  CmpItemKindMethod = { link = 'Function' },
  CmpItemKindFunction = { link = 'Function' },
  CmpItemKindConstructor = { link = 'Function' },
  CmpItemKindField = { fg = palette.purple },
  CmpItemKindProperty = { link = 'CmpItemKindField' },
  CmpItemKindVariable = { fg = palette.aqua },
  CmpItemKindReference = { link = 'CmpItemKindVariable' },
  CmpItemKindModule = { fg = palette.magenta },
  CmpItemKindEnum = { fg = palette.ochre },
  CmpItemKindEnumMember = { link = 'CmpItemKindEnum' },
  CmpItemKindKeyword = { link = 'Keyword' },
  CmpItemKindOperator = { link = 'Operator' },
  CmpItemKindSnippet = { fg = palette.tea },
  CmpItemKindColor = { fg = palette.pink },
  CmpItemKindConstant = { link = 'Constant' },
  CmpItemKindCopilot = { fg = palette.magenta },
  CmpItemKindValue = { link = 'Number' },
  CmpItemKindClass = { link = 'Type' },
  CmpItemKindStruct = { link = 'Type' },
  CmpItemKindEvent = { fg = palette.flashlight },
  CmpItemKindInterface = { fg = palette.flashlight },
  CmpItemKindFile = { link = 'DevIconDefault' },
  CmpItemKindFolder = { link = 'Directory' },
  CmpItemKindUnit = { fg = palette.cerulean },
  CmpItemKind = { fg = palette.smoke },
  CmpItemMenu = { fg = palette.smoke },
  CmpVirtualText = { fg = palette.steel, italic = true },

  -- gitsigns
  GitSignsAdd = { fg = palette.tea_blend },
  GitSignsAddInline = { fg = palette.tea, bg = palette.tea_blend },
  GitSignsAddLnInline = { fg = palette.tea, bg = palette.tea_blend },
  GitSignsAddPreview = { link = 'DiffAdded' },
  GitSignsChange = { fg = palette.lavender_blend },
  GitSignsChangeInline = { fg = palette.lavender, bg = palette.lavender_blend },
  GitSignsChangeLnInline = {
    fg = palette.lavender,
    bg = palette.lavender_blend,
  },
  GitSignsCurrentLineBlame = { fg = palette.smoke, bg = palette.smoke_blend },
  GitSignsDelete = { fg = palette.wine },
  GitSignsDeleteInline = { fg = palette.scarlet, bg = palette.scarlet_blend },
  GitSignsDeleteLnInline = { fg = palette.scarlet, bg = palette.scarlet_blend },
  GitSignsDeletePreview = { fg = palette.scarlet, bg = palette.wine_blend },
  GitSignsDeleteVirtLnInLine = {
    fg = palette.scarlet,
    bg = palette.scarlet_blend,
  },
  GitSignsUntracked = { fg = palette.scarlet_blend },
  GitSignsUntrackedLn = { bg = palette.scarlet_blend },
  GitSignsUntrackedNr = { fg = palette.pink },

  -- fugitive
  fugitiveHash = { link = 'gitHash' },
  fugitiveHeader = { link = 'Title' },
  fugitiveHeading = { fg = palette.orange, bold = true },
  fugitiveHelpTag = { fg = palette.orange },
  fugitiveSymbolicRef = { fg = palette.yellow },
  fugitiveStagedModifier = { fg = palette.tea, bold = true },
  fugitiveUnstagedModifier = { fg = palette.scarlet, bold = true },
  fugitiveUntrackedModifier = { fg = palette.pigeon, bold = true },
  fugitiveStagedHeading = { fg = palette.aqua, bold = true },
  fugitiveUnstagedHeading = { fg = palette.ochre, bold = true },
  fugitiveUntrackedHeading = { fg = palette.lavender, bold = true },

  -- telescope
  TelescopeNormal = { link = 'NormalFloat' },
  TelescopePromptNormal = { bg = palette.deepsea },
  TelescopeTitle = { fg = palette.space, bg = palette.turquoise, bold = true },
  TelescopePromptTitle = {
    fg = palette.space,
    bg = palette.yellow,
    bold = true,
  },
  TelescopeBorder = { fg = palette.smoke, bg = palette.ocean },
  TelescopePromptBorder = { fg = palette.smoke, bg = palette.deepsea },
  TelescopeSelection = { bg = palette.thunder },
  TelescopeMultiSelection = { bg = palette.thunder, bold = true },
  TelescopePreviewLine = { bg = palette.thunder },
  TelescopeMatching = { link = 'Search' },
  TelescopePromptCounter = { link = 'Comment' },
  TelescopePromptPrefix = { fg = palette.orange },
  TelescopeSelectionCaret = { fg = palette.orange, bg = palette.thunder },

  -- fidget
  FidgetTask = { fg = palette.thunder },
  FidgetTitle = { fg = palette.thunder, bold = true },

  -- nvim-dap-ui
  DapUIBreakpointsCurrentLine = { link = 'CursorLineNr' },
  DapUIBreakpointsInfo = { fg = palette.tea },
  DapUIBreakpointsPath = { link = 'Directory' },
  DapUICurrentFrameName = { fg = palette.tea, bold = true },
  DapUIDecoration = { fg = palette.yellow },
  DapUIFloatBorder = { link = 'FloatBorder' },
  DapUINormalFloat = { link = 'NormalFloat' },
  DapUILineNumber = { link = 'LineNr' },
  DapUIModifiedValue = { fg = palette.skyblue, bold = true },
  DapUIPlayPause = { fg = palette.tea },
  DapUIPlayPauseNC = { fg = palette.tea },
  DapUIRestart = { fg = palette.tea },
  DapUIRestartNC = { fg = palette.tea },
  DapUIScope = { fg = palette.orange },
  DapUISource = { link = 'Directory' },
  DapUIStepBack = { fg = palette.lavender },
  DapUIStepBackRC = { fg = palette.lavender },
  DapUIStepInto = { fg = palette.lavender },
  DapUIStepIntoRC = { fg = palette.lavender },
  DapUIStepOut = { fg = palette.lavender },
  DapUIStepOutRC = { fg = palette.lavender },
  DapUIStepOver = { fg = palette.lavender },
  DapUIStepOverRC = { fg = palette.lavender },
  DapUIStop = { fg = palette.scarlet },
  DapUIStopNC = { fg = palette.scarlet },
  DapUIStoppedThread = { fg = palette.tea },
  DapUIThread = { fg = palette.aqua },
  DapUIType = { link = 'Type' },
  DapUIVariable = { link = 'Identifier' },
  DapUIWatchesEmpty = { link = 'Comment' },
  DapUIWatchesError = { link = 'Error' },
  DapUIWatchesValue = { fg = palette.orange },

  -- vimtex
  texArg = { fg = palette.pigeon },
  texArgNew = { fg = palette.skyblue },
  texCmd = { fg = palette.yellow },
  texCmdBib = { link = 'texCmd' },
  texCmdClass = { link = 'texCmd' },
  texCmdDef = { link = 'texCmd' },
  texCmdE3 = { link = 'texCmd' },
  texCmdEnv = { link = 'texCmd' },
  texCmdEnvM = { link = 'texCmd' },
  texCmdError = { link = 'ErrorMsg' },
  texCmdFatal = { link = 'ErrorMsg' },
  texCmdGreek = { link = 'texCmd' },
  texCmdInput = { link = 'texCmd' },
  texCmdItem = { link = 'texCmd' },
  texCmdLet = { link = 'texCmd' },
  texCmdMath = { link = 'texCmd' },
  texCmdNew = { link = 'texCmd' },
  texCmdPart = { link = 'texCmd' },
  texCmdRef = { link = 'texCmd' },
  texCmdSize = { link = 'texCmd' },
  texCmdStyle = { link = 'texCmd' },
  texCmdTitle = { link = 'texCmd' },
  texCmdTodo = { link = 'texCmd' },
  texCmdType = { link = 'texCmd' },
  texCmdVerb = { link = 'texCmd' },
  texComment = { link = 'Comment' },
  texDefParm = { link = 'Keyword' },
  texDelim = { fg = palette.pigeon },
  texE3Cmd = { link = 'texCmd' },
  texE3Delim = { link = 'texDelim' },
  texE3Opt = { link = 'texOpt' },
  texE3Parm = { link = 'texParm' },
  texE3Type = { link = 'texCmd' },
  texEnvOpt = { link = 'texOpt' },
  texError = { link = 'ErrorMsg' },
  texFileArg = { link = 'Directory' },
  texFileOpt = { link = 'texOpt' },
  texFilesArg = { link = 'texFileArg' },
  texFilesOpt = { link = 'texFileOpt' },
  texLength = { fg = palette.lavender },
  texLigature = { fg = palette.pigeon },
  texOpt = { fg = palette.smoke },
  texOptEqual = { fg = palette.orange },
  texOptSep = { fg = palette.orange },
  texParm = { fg = palette.pigeon },
  texRefArg = { fg = palette.lavender },
  texRefOpt = { link = 'texOpt' },
  texSymbol = { fg = palette.orange },
  texTitleArg = { link = 'Title' },
  texVerbZone = { fg = palette.pigeon },
  texZone = { fg = palette.aqupigeon },
  texMathArg = { fg = palette.pigeon },
  texMathCmd = { link = 'texCmd' },
  texMathSub = { fg = palette.pigeon },
  texMathOper = { fg = palette.orange },
  texMathZone = { fg = palette.yellow },
  texMathDelim = { fg = palette.smoke },
  texMathError = { link = 'Error' },
  texMathGroup = { fg = palette.pigeon },
  texMathSuper = { fg = palette.pigeon },
  texMathSymbol = { fg = palette.yellow },
  texMathZoneLD = { fg = palette.pigeon },
  texMathZoneLI = { fg = palette.pigeon },
  texMathZoneTD = { fg = palette.pigeon },
  texMathZoneTI = { fg = palette.pigeon },
  texMathCmdText = { link = 'texCmd' },
  texMathZoneEnv = { fg = palette.pigeon },
  texMathArrayArg = { fg = palette.yellow },
  texMathCmdStyle = { link = 'texCmd' },
  texMathDelimMod = { fg = palette.smoke },
  texMathSuperSub = { fg = palette.smoke },
  texMathDelimZone = { fg = palette.pigeon },
  texMathStyleBold = { fg = palette.smoke, bold = true },
  texMathStyleItal = { fg = palette.smoke, italic = true },
  texMathEnvArgName = { fg = palette.lavender },
  texMathErrorDelim = { link = 'Error' },
  texMathDelimZoneLD = { fg = palette.steel },
  texMathDelimZoneLI = { fg = palette.steel },
  texMathDelimZoneTD = { fg = palette.steel },
  texMathDelimZoneTI = { fg = palette.steel },
  texMathZoneEnsured = { fg = palette.pigeon },
  texMathCmdStyleBold = { fg = palette.yellow, bold = true },
  texMathCmdStyleItal = { fg = palette.yellow, italic = true },
  texMathStyleConcArg = { fg = palette.pigeon },
  texMathZoneEnvStarred = { fg = palette.pigeon },

  -- lazy.nvim
  LazyDir = { link = 'Directory' },
  LazyUrl = { link = 'htmlLink' },
  LazySpecial = { fg = palette.orange },
  LazyCommit = { fg = palette.tea },
  LazyReasonFt = { fg = palette.pigeon },
  LazyReasonCmd = { fg = palette.yellow },
  LazyReasonPlugin = { fg = palette.turquoise },
  LazyReasonSource = { fg = palette.orange },
  LazyReasonRuntime = { fg = palette.lavender },
  LazyReasonEvent = { fg = palette.flashlight },
  LazyReasonKeys = { fg = palette.pink },
  LazyButton = { bg = palette.ocean },
  LazyButtonActive = { bg = palette.thunder, bold = true },
  LazyH1 = { fg = palette.space, bg = palette.yellow, bold = true },

  -- copilot.lua
  CopilotSuggestion = { fg = palette.steel, italic = true },
  CopilotAnnotation = { fg = palette.steel, italic = true },

  -- statusline plugin
  StatusLineFaded = { fg = palette.pigeon, bg = palette.deepsea },
  StatusLineGitAdded = { fg = palette.tea, bg = palette.deepsea },
  StatusLineGitChanged = { fg = palette.lavender, bg = palette.deepsea },
  StatusLineGitRemoved = { fg = palette.scarlet, bg = palette.deepsea },
  StatusLineHeader = { fg = palette.jeans, bg = palette.steel },
  StatusLineHeaderModified = { fg = palette.jeans, bg = palette.pink },
  StatusLineStrong = { fg = palette.white, bg = palette.deepsea, bold = true },
  -- }}}2

  -- Extra {{{2
  Yellow = { fg = palette.yellow },
  Earth = { fg = palette.earth },
  Orange = { fg = palette.orange },
  Scarlet = { fg = palette.scarlet },
  Ochre = { fg = palette.ochre },
  Wine = { fg = palette.wine },
  Pink = { fg = palette.pink },
  Tea = { fg = palette.tea },
  Flashlight = { fg = palette.flashlight },
  Aqua = { fg = palette.aqua },
  Cerulean = { fg = palette.cerulean },
  SkyBlue = { fg = palette.skyblue },
  Turquoise = { fg = palette.turquoise },
  Lavender = { fg = palette.lavender },
  Magenta = { fg = palette.magenta },
  Purple = { fg = palette.purple },
  Thunder = { fg = palette.thunder },
  White = { fg = palette.white },
  Beige = { fg = palette.beige },
  Pigeon = { fg = palette.pigeon },
  Steel = { fg = palette.steel },
  Smoke = { fg = palette.smoke },
  Iron = { fg = palette.iron },
  Deepsea = { fg = palette.deepsea },
  Ocean = { fg = palette.ocean },
  Space = { fg = palette.space },
  Black = { fg = palette.black },
  -- }}}2
}
-- }}}1

-- Set highlight groups {{{1
vim.cmd.hi('clear')
for termcolor, hex in pairs(termcolors) do
  vim.g[termcolor] = hex
end
for hlgroup_name, hlgroup_attr in pairs(hlgroups) do
  vim.api.nvim_set_hl(0, hlgroup_name, hlgroup_attr)
end
vim.g.colors_name = 'cockatoo'
-- }}}1

-- vim:ts=2:sw=2:sts=2:fdm=marker:fdl=0
