local Color, colors, Group, groups, styles = require('colorbuddy').setup()
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

if Color == nil then return end
if Group == nil then return end
if colors == nil then return end
if groups == nil then return end
if styles == nil then return end

Color.new('background',     '#282c3e')
Color.new('red',            '#f07178')
Color.new('green',          '#c3e88d')
Color.new('yellow',         '#ffcb6b')
Color.new('blue',           '#82aaff')
Color.new('light_blue',     '#66b7a6')
Color.new('magenta',        '#c792ea')
Color.new('pink',           '#af66b7')
Color.new('cyan',           '#89ddff')
Color.new('white',          '#d0d0d0')
Color.new('gray',           '#4e5460')
Color.new('gray2',          '#596170')
Color.new('gray3',          '#444444')

-- Syntax Groups (descriptions and ordering from `:h w18`
Group.new('Comment'         , (colors.gray:light()):light()  , nil , styles.italic)
Group.new('Constant'        , colors.yellow        , nil , nil)
Group.new('String'          , colors.green         , nil , nil)
Group.new('Character'       , colors.green         , nil , nil)
Group.new('Number'          , colors.magenta       , nil , nil)
Group.new('boolean'         , colors.magenta       , nil , styles.bold)
Group.new('Float'           , colors.magenta       , nil , nil)
Group.new('Identifier'      , colors.magenta       , nil , nil) Group.new('Function'        , colors.blue          , nil , styles.bold)
Group.new('Statement'       , colors.blue:light()  , nil , styles.bold)
Group.new('Conditional'     , colors.blue:light()  , nil , styles.bold)
Group.new('Repeat	  '       , colors.blue:light()  , nil , styles.bold)
Group.new('Label	  '       , colors.blue:light()  , nil , styles.bold)
Group.new('Operator '       , colors.blue:light()  , nil , styles.bold)
Group.new('Keyword  '       , colors.blue:light()  , nil , styles.bold)
Group.new('Exception'       , colors.blue:light()  , nil , styles.bold)

Group.new('PreProc  '       , colors.cyan          , nil , nil)
Group.new('Include  '       , colors.cyan          , nil , nil)
Group.new('Define	  '       , colors.cyan          , nil , nil)
Group.new('Macro	  '       , colors.cyan          , nil , nil)
Group.new('PreCondit'       , colors.cyan          , nil , nil)

Group.new('Type		     '    , colors.magenta       , nil , styles.bold)
Group.new('StorageClass'    , colors.magenta       , nil , styles.bold)
Group.new('Structure   '    , colors.magenta       , nil , styles.bold)
Group.new('Typedef     '    , colors.magenta       , nil , styles.bold)

Group.new('Special'         , colors.yellow:light() , nil , nil)
Group.new('SpecialChar'     , colors.yellow:light() , nil , nil)
Group.new('Tag'             , colors.yellow:light() , nil , nil)
Group.new('Delimiter'       , colors.yellow:light() , nil , nil)
Group.new('SpecialComment'  , colors.yellow:light() , nil , nil)
Group.new('Debug'           , colors.yellow:light() , nil , nil)
Group.new('Underlined'      , colors.blue:dark()   , nil , nil)
Group.new('Ignore'          , colors.gray:light()  , nil , nil)
Group.new('Error'           , colors.red:light()   , nil , styles.bold)
Group.new('Todo'            , colors.yellow:light(), nil , nil)

-- Highlighting Groups (see :h highlight-groups)
Group.new('LineNr'          , colors.gray:light()         , nil , nil)
Group.new('CursorLineNr'    , colors.white                , colors.background:light() , nil)
Group.new('VertSplit'       , colors.gray                 , colors.background , nil)
Group.new('SignColumn'      , nil                         , colors.background:light() , nil)
Group.new('ColorColumn'     , nil                         , colors.background:light(), nil)
Group.new('Visual'          , nil                         , colors.background:light(), nil)
Group.new('Directory'       , colors.yellow:dark()        , nil, nil)
Group.new('MatchParen'      , colors.cyan                 , nil, styles.underline)
Group.new('TabLine'         , colors.white                , colors.gray, nil)
Group.new('TabLineFill'     , nil                         , colors.background:light(), nil)
Group.new('TabLineSel'      , colors.black                , colors.blue, nil)

-- language specific colors
-- typescript:
Group.new('typescriptBraces', colors.blue:light()         , nil, nil)
-- lua:
Group.new('luaFunctionCall', groups.Function, groups.Function, groups.Function)
-- latex
Group.new('latexTSTitle', colors.green, nil, nil)
-- rust
Group.new('rustTSType', colors.red, nil, nil)
Group.new('rustTSNamespace', colors.blue, nil, nil)

-- Group.new("CmpItemAbbr", g.Comment)
-- Group.new("CmpItemAbbrDeprecated", g.Error)
-- Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
-- Group.new("CmpItemKind", g.Special)
-- Group.new("CmpItemMenu", g.NonText)

-- Statusline
local statusline_highlights = {
  {'Statusline',   { fg = '#3C3836', bg = '#89AAFF' }},
  {'StatuslineNC', { fg = '#d0d0d0', bg = '#5c6370' }},
  {'Mode',         { fg = '#d0d0d0', bg = '#5c6370', gui="bold" }},
  {'Git',          { fg = '#EBDBB2', bg = '#3e4b59' }},
}

return {
    highlights = statusline_highlights
}
