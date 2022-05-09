" vim:fdm=marker
" Vim Color File
" Name:       onedark.vim
" Maintainer: https://github.com/joshdick/onedark.vim/
" License:    The MIT License (MIT)
" Based On:   https://github.com/MaxSt/FlatColor/

" Companion statusline plugin and terminal themes are included with onedark.vim:
"  * https://github.com/joshdick/onedark.vim#lightlinevim-colorscheme
"  * https://github.com/joshdick/onedark.vim#vim-airline-theme
"  * https://github.com/joshdick/onedark.vim/tree/main/term

" Color Reference {{{

" The following colors were measured inside Atom using its built-in inspector.

" +---------------------------------------------+
" |  Color Name  |         RGB        |   Hex   |
" |--------------+--------------------+---------|
" | Black        | rgb(40, 44, 52)    | #282c34 |
" |--------------+--------------------+---------|
" | White        | rgb(171, 178, 191) | #abb2bf |
" |--------------+--------------------+---------|
" | Light Red    | rgb(224, 108, 117) | #e06c75 |
" |--------------+--------------------+---------|
" | Dark Red     | rgb(190, 80, 70)   | #be5046 |
" |--------------+--------------------+---------|
" | Green        | rgb(152, 195, 121) | #98c379 |
" |--------------+--------------------+---------|
" | Light Yellow | rgb(229, 192, 123) | #e5c07b |
" |--------------+--------------------+---------|
" | Dark Yellow  | rgb(209, 154, 102) | #d19a66 |
" |--------------+--------------------+---------|
" | Blue         | rgb(97, 175, 239)  | #61afef |
" |--------------+--------------------+---------|
" | Magenta      | rgb(198, 120, 221) | #c678dd |
" |--------------+--------------------+---------|
" | Cyan         | rgb(86, 182, 194)  | #56b6c2 |
" |--------------+--------------------+---------|
" | Gutter Grey  | rgb(76, 82, 99)    | #4b5263 |
" |--------------+--------------------+---------|
" | Comment Grey | rgb(92, 99, 112)   | #5c6370 |
" +---------------------------------------------+

" }}}

" Initialization {{{

highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:colors_name="onedark"

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/joshdick/onedark.vim/blob/main/README.md >
" for more information.)
if !exists("g:onedark_termcolors")
  let g:onedark_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:onedark_terminal_italics")
  let g:onedark_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `onedark#extend_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from onedark#extend_highlight
    let s:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(s:highlight, style_type) ? copy(s:highlight[style_type]) : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let s:highlight.gui = a:style.gui
    endif
  else
    let s:highlight = a:style
    let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
  endif

  if g:onedark_terminal_italics == 0
    if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
      unlet s:highlight.cterm
    endif
    if has_key(s:highlight, "gui") && s:highlight["gui"] == "italic"
      unlet s:highlight.gui
    endif
  endif

  if g:onedark_termcolors == 16
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(s:highlight, "fg")    ? s:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(s:highlight, "bg")    ? s:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(s:highlight, "sp")    ? s:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(s:highlight, "gui")   ? s:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")
endfunction

" public {{{

function! onedark#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

function! onedark#extend_highlight(group, style)
  call s:h(a:group, a:style, 1)
endfunction

" }}}

" }}}

" Color Variables {{{

let s:colors = onedark#GetColors()

let s:red = s:colors.red
let s:dark_red = s:colors.dark_red
let s:green = s:colors.green
let s:yellow = s:colors.yellow
let s:dark_yellow = s:colors.dark_yellow
let s:blue = s:colors.blue
let s:purple = s:colors.purple
let s:cyan = s:colors.cyan
let s:white = s:colors.white
let s:black = s:colors.black
let s:foreground = s:colors.foreground
let s:background = s:colors.background
let s:comment_grey = s:colors.comment_grey
let s:gutter_fg_grey = s:colors.gutter_fg_grey
let s:cursor_grey = s:colors.cursor_grey
let s:visual_grey = s:colors.visual_grey
let s:menu_grey = s:colors.menu_grey
let s:special_grey = s:colors.special_grey
let s:vertsplit = s:colors.vertsplit

" }}}

" Terminal Colors {{{

if has('nvim')
  let g:terminal_color_0 = s:black.gui
  let g:terminal_color_1 = s:red.gui
  let g:terminal_color_2 = s:green.gui
  let g:terminal_color_3 = s:yellow.gui
  let g:terminal_color_4 = s:blue.gui
  let g:terminal_color_5 = s:purple.gui
  let g:terminal_color_6 = s:cyan.gui
  let g:terminal_color_7 = s:comment_grey.gui
  let g:terminal_color_8 = s:visual_grey.gui
  let g:terminal_color_9 = s:red.gui
  let g:terminal_color_10 = s:green.gui
  let g:terminal_color_11 = s:yellow.gui
  let g:terminal_color_12 = s:blue.gui
  let g:terminal_color_13 = s:purple.gui
  let g:terminal_color_14 = s:cyan.gui
  let g:terminal_color_15 = s:white.gui
else
  let g:terminal_ansi_colors = [
    \ s:black.gui, s:red.gui, s:green.gui, s:yellow.gui,
    \ s:blue.gui, s:purple.gui, s:cyan.gui, s:comment_grey.gui,
    \ s:visual_grey.gui, s:red.gui, s:green.gui, s:yellow.gui,
    \ s:blue.gui, s:purple.gui, s:cyan.gui, s:white.gui
  \]
endif

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan }) " any constant
call s:h("String", { "fg": s:green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:dark_yellow }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:dark_yellow }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:dark_yellow }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:red }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:purple }) " any statement
call s:h("Conditional", { "fg": s:purple }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:purple }) " for, do, while, etc.
call s:h("Label", { "fg": s:purple }) " case, default, etc.
call s:h("Operator", { "fg": s:purple }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:red }) " any other keyword
call s:h("Exception", { "fg": s:purple }) " try, catch, throw
call s:h("PreProc", { "fg": s:yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:purple }) " preprocessor #define
call s:h("Macro", { "fg": s:purple }) " same as Define
call s:h("PreCondit", { "fg": s:yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:yellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:yellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:yellow }) " A typedef
call s:h("Special", { "fg": s:blue }) " any special symbol
call s:h("SpecialChar", { "fg": s:dark_yellow }) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" }}}

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{
call s:h("ColorColumn", { "bg": s:cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
  " Don't change the background color in diff mode
  call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:black }) " diff mode: Added line
call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:yellow, "fg": s:black }) " diff mode: Changed text within a changed line
if get(g:, 'onedark_hide_endofbuffer', 0)
    " If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
    call s:h("EndOfBuffer", { "fg": s:black }) " filler lines (~) after the last line in the buffer
endif
call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:vertsplit }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:yellow, "bg": s:comment_grey }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:blue, "gui": "underline", "cterm": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:foreground, "bg": s:background }) " normal text
call s:h("Pmenu", { "fg": s:white, "bg": s:menu_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:cursor_grey, "bg": s:blue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:cursor_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:purple }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow }) " Current quickfix item in the quickfix window.
call s:h("Search", { "fg": s:black, "bg": s:yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:white, "bg": s:cursor_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:white, "bg": s:cursor_grey }) " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:comment_grey }) " status line of non-current :terminal window
call s:h("TabLine", { "fg": s:comment_grey }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:white, "bg": s:black }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "bg": s:visual_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
call s:h("WildMenu", { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion

" }}}

" Termdebug highlighting for Vim 8.1+ {{{

" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
call s:h("debugPC", { "bg": s:special_grey }) " the current position
call s:h("debugBreakpoint", { "fg": s:black, "bg": s:red }) " a breakpoint

" }}}

" Language-Specific Highlighting {{{

" CSS
call s:h("cssAttrComma", { "fg": s:purple })
call s:h("cssAttributeSelector", { "fg": s:green })
call s:h("cssBraces", { "fg": s:white })
call s:h("cssClassName", { "fg": s:dark_yellow })
call s:h("cssClassNameDot", { "fg": s:dark_yellow })
call s:h("cssDefinition", { "fg": s:purple })
call s:h("cssFontAttr", { "fg": s:dark_yellow })
call s:h("cssFontDescriptor", { "fg": s:purple })
call s:h("cssFunctionName", { "fg": s:blue })
call s:h("cssIdentifier", { "fg": s:blue })
call s:h("cssImportant", { "fg": s:purple })
call s:h("cssInclude", { "fg": s:white })
call s:h("cssIncludeKeyword", { "fg": s:purple })
call s:h("cssMediaType", { "fg": s:dark_yellow })
call s:h("cssProp", { "fg": s:white })
call s:h("cssPseudoClassId", { "fg": s:dark_yellow })
call s:h("cssSelectorOp", { "fg": s:purple })
call s:h("cssSelectorOp2", { "fg": s:purple })
call s:h("cssTagName", { "fg": s:red })

" Fish Shell
call s:h("fishKeyword", { "fg": s:purple })
call s:h("fishConditional", { "fg": s:purple })

" Go
call s:h("goDeclaration", { "fg": s:purple })
call s:h("goBuiltins", { "fg": s:cyan })
call s:h("goFunctionCall", { "fg": s:blue })
call s:h("goVarDefs", { "fg": s:red })
call s:h("goVarAssign", { "fg": s:red })
call s:h("goVar", { "fg": s:purple })
call s:h("goConst", { "fg": s:purple })
call s:h("goType", { "fg": s:yellow })
call s:h("goTypeName", { "fg": s:yellow })
call s:h("goDeclType", { "fg": s:cyan })
call s:h("goTypeDecl", { "fg": s:purple })

" HTML (keep consistent with Markdown, below)
call s:h("htmlArg", { "fg": s:dark_yellow })
call s:h("htmlBold", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("htmlBoldItalic", { "fg": s:green, "gui": "bold,italic", "cterm": "bold,italic" })
call s:h("htmlEndTag", { "fg": s:white })
call s:h("htmlH1", { "fg": s:red })
call s:h("htmlH2", { "fg": s:red })
call s:h("htmlH3", { "fg": s:red })
call s:h("htmlH4", { "fg": s:red })
call s:h("htmlH5", { "fg": s:red })
call s:h("htmlH6", { "fg": s:red })
call s:h("htmlItalic", { "fg": s:purple, "gui": "italic", "cterm": "italic" })
call s:h("htmlLink", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })
call s:h("htmlSpecialChar", { "fg": s:dark_yellow })
call s:h("htmlSpecialTagName", { "fg": s:red })
call s:h("htmlTag", { "fg": s:white })
call s:h("htmlTagN", { "fg": s:red })
call s:h("htmlTagName", { "fg": s:red })
call s:h("htmlTitle", { "fg": s:white })

" JavaScript
call s:h("javaScriptBraces", { "fg": s:white })
call s:h("javaScriptFunction", { "fg": s:purple })
call s:h("javaScriptIdentifier", { "fg": s:purple })
call s:h("javaScriptNull", { "fg": s:dark_yellow })
call s:h("javaScriptNumber", { "fg": s:dark_yellow })
call s:h("javaScriptRequire", { "fg": s:cyan })
call s:h("javaScriptReserved", { "fg": s:purple })
" https://github.com/pangloss/vim-javascript
call s:h("jsArrowFunction", { "fg": s:purple })
call s:h("jsClassKeyword", { "fg": s:purple })
call s:h("jsClassMethodType", { "fg": s:purple })
call s:h("jsDocParam", { "fg": s:blue })
call s:h("jsDocTags", { "fg": s:purple })
call s:h("jsExport", { "fg": s:purple })
call s:h("jsExportDefault", { "fg": s:purple })
call s:h("jsExtendsKeyword", { "fg": s:purple })
call s:h("jsFrom", { "fg": s:purple })
call s:h("jsFuncCall", { "fg": s:blue })
call s:h("jsFunction", { "fg": s:purple })
call s:h("jsGenerator", { "fg": s:yellow })
call s:h("jsGlobalObjects", { "fg": s:yellow })
call s:h("jsImport", { "fg": s:purple })
call s:h("jsModuleAs", { "fg": s:purple })
call s:h("jsModuleWords", { "fg": s:purple })
call s:h("jsModules", { "fg": s:purple })
call s:h("jsNull", { "fg": s:dark_yellow })
call s:h("jsOperator", { "fg": s:purple })
call s:h("jsStorageClass", { "fg": s:purple })
call s:h("jsSuper", { "fg": s:red })
call s:h("jsTemplateBraces", { "fg": s:dark_red })
call s:h("jsTemplateVar", { "fg": s:green })
call s:h("jsThis", { "fg": s:red })
call s:h("jsUndefined", { "fg": s:dark_yellow })
" https://github.com/othree/yajs.vim
call s:h("javascriptArrowFunc", { "fg": s:purple })
call s:h("javascriptClassExtends", { "fg": s:purple })
call s:h("javascriptClassKeyword", { "fg": s:purple })
call s:h("javascriptDocNotation", { "fg": s:purple })
call s:h("javascriptDocParamName", { "fg": s:blue })
call s:h("javascriptDocTags", { "fg": s:purple })
call s:h("javascriptEndColons", { "fg": s:white })
call s:h("javascriptExport", { "fg": s:purple })
call s:h("javascriptFuncArg", { "fg": s:white })
call s:h("javascriptFuncKeyword", { "fg": s:purple })
call s:h("javascriptIdentifier", { "fg": s:red })
call s:h("javascriptImport", { "fg": s:purple })
call s:h("javascriptMethodName", { "fg": s:white })
call s:h("javascriptObjectLabel", { "fg": s:white })
call s:h("javascriptOpSymbol", { "fg": s:cyan })
call s:h("javascriptOpSymbols", { "fg": s:cyan })
call s:h("javascriptPropertyName", { "fg": s:green })
call s:h("javascriptTemplateSB", { "fg": s:dark_red })
call s:h("javascriptVariable", { "fg": s:purple })

" JSON
call s:h("jsonCommentError", { "fg": s:white })
call s:h("jsonKeyword", { "fg": s:red })
call s:h("jsonBoolean", { "fg": s:dark_yellow })
call s:h("jsonNumber", { "fg": s:dark_yellow })
call s:h("jsonQuote", { "fg": s:white })
call s:h("jsonMissingCommaError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNumError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonString", { "fg": s:green })
call s:h("jsonStringSQError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": s:red, "gui": "reverse" })

" LESS
call s:h("lessVariable", { "fg": s:purple })
call s:h("lessAmpersandChar", { "fg": s:white })
call s:h("lessClass", { "fg": s:dark_yellow })

" Markdown (keep consistent with HTML, above)
call s:h("markdownBlockquote", { "fg": s:comment_grey })
call s:h("markdownBold", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("markdownBoldItalic", { "fg": s:green, "gui": "bold,italic", "cterm": "bold,italic" })
call s:h("markdownCode", { "fg": s:green })
call s:h("markdownCodeBlock", { "fg": s:green })
call s:h("markdownCodeDelimiter", { "fg": s:green })
call s:h("markdownH1", { "fg": s:red })
call s:h("markdownH2", { "fg": s:red })
call s:h("markdownH3", { "fg": s:red })
call s:h("markdownH4", { "fg": s:red })
call s:h("markdownH5", { "fg": s:red })
call s:h("markdownH6", { "fg": s:red })
call s:h("markdownHeadingDelimiter", { "fg": s:red })
call s:h("markdownHeadingRule", { "fg": s:comment_grey })
call s:h("markdownId", { "fg": s:purple })
call s:h("markdownIdDeclaration", { "fg": s:blue })
call s:h("markdownIdDelimiter", { "fg": s:purple })
call s:h("markdownItalic", { "fg": s:purple, "gui": "italic", "cterm": "italic" })
call s:h("markdownLinkDelimiter", { "fg": s:purple })
call s:h("markdownLinkText", { "fg": s:blue })
call s:h("markdownListMarker", { "fg": s:red })
call s:h("markdownOrderedListMarker", { "fg": s:red })
call s:h("markdownRule", { "fg": s:comment_grey })
call s:h("markdownUrl", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" Perl
call s:h("perlFiledescRead", { "fg": s:green })
call s:h("perlFunction", { "fg": s:purple })
call s:h("perlMatchStartEnd",{ "fg": s:blue })
call s:h("perlMethod", { "fg": s:purple })
call s:h("perlPOD", { "fg": s:comment_grey })
call s:h("perlSharpBang", { "fg": s:comment_grey })
call s:h("perlSpecialString",{ "fg": s:dark_yellow })
call s:h("perlStatementFiledesc", { "fg": s:red })
call s:h("perlStatementFlow",{ "fg": s:red })
call s:h("perlStatementInclude", { "fg": s:purple })
call s:h("perlStatementScalar",{ "fg": s:purple })
call s:h("perlStatementStorage", { "fg": s:purple })
call s:h("perlSubName",{ "fg": s:yellow })
call s:h("perlVarPlain",{ "fg": s:blue })

" PHP
call s:h("phpVarSelector", { "fg": s:red })
call s:h("phpOperator", { "fg": s:white })
call s:h("phpParent", { "fg": s:white })
call s:h("phpMemberSelector", { "fg": s:white })
call s:h("phpType", { "fg": s:purple })
call s:h("phpKeyword", { "fg": s:purple })
call s:h("phpClass", { "fg": s:yellow })
call s:h("phpUseClass", { "fg": s:white })
call s:h("phpUseAlias", { "fg": s:white })
call s:h("phpInclude", { "fg": s:purple })
call s:h("phpClassExtends", { "fg": s:green })
call s:h("phpDocTags", { "fg": s:white })
call s:h("phpFunction", { "fg": s:blue })
call s:h("phpFunctions", { "fg": s:cyan })
call s:h("phpMethodsVar", { "fg": s:dark_yellow })
call s:h("phpMagicConstants", { "fg": s:dark_yellow })
call s:h("phpSuperglobals", { "fg": s:red })
call s:h("phpConstants", { "fg": s:dark_yellow })

" Ruby
call s:h("rubyBlockParameter", { "fg": s:red})
call s:h("rubyBlockParameterList", { "fg": s:red })
call s:h("rubyClass", { "fg": s:purple})
call s:h("rubyConstant", { "fg": s:yellow})
call s:h("rubyControl", { "fg": s:purple })
call s:h("rubyEscape", { "fg": s:red})
call s:h("rubyFunction", { "fg": s:blue})
call s:h("rubyGlobalVariable", { "fg": s:red})
call s:h("rubyInclude", { "fg": s:blue})
call s:h("rubyIncluderubyGlobalVariable", { "fg": s:red})
call s:h("rubyInstanceVariable", { "fg": s:red})
call s:h("rubyInterpolation", { "fg": s:cyan })
call s:h("rubyInterpolationDelimiter", { "fg": s:red })
call s:h("rubyInterpolationDelimiter", { "fg": s:red})
call s:h("rubyRegexp", { "fg": s:cyan})
call s:h("rubyRegexpDelimiter", { "fg": s:cyan})
call s:h("rubyStringDelimiter", { "fg": s:green})
call s:h("rubySymbol", { "fg": s:cyan})

" Sass
" https://github.com/tpope/vim-haml
call s:h("sassAmpersand", { "fg": s:red })
call s:h("sassClass", { "fg": s:dark_yellow })
call s:h("sassControl", { "fg": s:purple })
call s:h("sassExtend", { "fg": s:purple })
call s:h("sassFor", { "fg": s:white })
call s:h("sassFunction", { "fg": s:cyan })
call s:h("sassId", { "fg": s:blue })
call s:h("sassInclude", { "fg": s:purple })
call s:h("sassMedia", { "fg": s:purple })
call s:h("sassMediaOperators", { "fg": s:white })
call s:h("sassMixin", { "fg": s:purple })
call s:h("sassMixinName", { "fg": s:blue })
call s:h("sassMixing", { "fg": s:purple })
call s:h("sassVariable", { "fg": s:purple })
" https://github.com/cakebaker/scss-syntax.vim
call s:h("scssExtend", { "fg": s:purple })
call s:h("scssImport", { "fg": s:purple })
call s:h("scssInclude", { "fg": s:purple })
call s:h("scssMixin", { "fg": s:purple })
call s:h("scssSelectorName", { "fg": s:dark_yellow })
call s:h("scssVariable", { "fg": s:purple })

" TeX
call s:h("texStatement", { "fg": s:purple })
call s:h("texSubscripts", { "fg": s:dark_yellow })
call s:h("texSuperscripts", { "fg": s:dark_yellow })
call s:h("texTodo", { "fg": s:dark_red })
call s:h("texBeginEnd", { "fg": s:purple })
call s:h("texBeginEndName", { "fg": s:blue })
call s:h("texMathMatcher", { "fg": s:blue })
call s:h("texMathDelim", { "fg": s:blue })
call s:h("texDelimiter", { "fg": s:dark_yellow })
call s:h("texSpecialChar", { "fg": s:dark_yellow })
call s:h("texCite", { "fg": s:blue })
call s:h("texRefZone", { "fg": s:blue })

" TypeScript
call s:h("typescriptReserved", { "fg": s:purple })
call s:h("typescriptEndColons", { "fg": s:white })
call s:h("typescriptBraces", { "fg": s:white })

" XML
call s:h("xmlAttrib", { "fg": s:dark_yellow })
call s:h("xmlEndTag", { "fg": s:red })
call s:h("xmlTag", { "fg": s:red })
call s:h("xmlTagName", { "fg": s:red })

" }}}

" Plugin Highlighting {{{

" airblade/vim-gitgutter
call s:h("GitGutterAdd", { "fg": s:green })
call s:h("GitGutterChange", { "fg": s:yellow })
call s:h("GitGutterDelete", { "fg": s:red })

" dense-analysis/ale
call s:h("ALEError", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("ALEWarning", { "fg": s:yellow, "gui": "underline", "cterm": "underline"})
call s:h("ALEInfo", { "gui": "underline", "cterm": "underline"})

" easymotion/vim-easymotion
call s:h("EasyMotionTarget", { "fg": s:red, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2First", { "fg": s:yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2Second", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionShade",  { "fg": s:comment_grey })

" lewis6991/gitsigns.nvim
hi link GitSignsAdd    GitGutterAdd
hi link GitSignsChange GitGutterChange
hi link GitSignsDelete GitGutterDelete

" mhinz/vim-signify
hi link SignifySignAdd    GitGutterAdd
hi link SignifySignChange GitGutterChange
hi link SignifySignDelete GitGutterDelete

" neoclide/coc.nvim
call s:h("CocErrorSign", { "fg": s:red })
call s:h("CocWarningSign", { "fg": s:yellow })
call s:h("CocInfoSign", { "fg": s:blue })
call s:h("CocHintSign", { "fg": s:cyan })
call s:h("CocFadeOut", { "fg": s:comment_grey })

" neomake/neomake
call s:h("NeomakeErrorSign", { "fg": s:red })
call s:h("NeomakeWarningSign", { "fg": s:yellow })
call s:h("NeomakeInfoSign", { "fg": s:blue })

" plasticboy/vim-markdown (keep consistent with Markdown, above)
call s:h("mkdDelimiter", { "fg": s:purple })
call s:h("mkdHeading", { "fg": s:red })
call s:h("mkdLink", { "fg": s:blue })
call s:h("mkdURL", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" prabirshrestha/vim-lsp
call s:h("LspError", { "fg": s:red })
call s:h("LspWarning", { "fg": s:yellow })
call s:h("LspInformation", { "fg": s:blue })
call s:h("LspHint", { "fg": s:cyan })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })

" }}}

" Git Highlighting {{{

call s:h("gitcommitComment", { "fg": s:comment_grey })
call s:h("gitcommitUnmerged", { "fg": s:green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:purple })
call s:h("gitcommitDiscardedType", { "fg": s:red })
call s:h("gitcommitSelectedType", { "fg": s:green })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:cyan })
call s:h("gitcommitDiscardedFile", { "fg": s:red })
call s:h("gitcommitSelectedFile", { "fg": s:green })
call s:h("gitcommitUnmergedFile", { "fg": s:yellow })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:white })
call s:h("gitcommitOverflow", { "fg": s:red })
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" }}}

" Neovim-Specific Highlighting {{{

if has("nvim")
  " Neovim terminal colors {{{
  let g:terminal_color_0 =  s:black.gui
  let g:terminal_color_1 =  s:red.gui
  let g:terminal_color_2 =  s:green.gui
  let g:terminal_color_3 =  s:yellow.gui
  let g:terminal_color_4 =  s:blue.gui
  let g:terminal_color_5 =  s:purple.gui
  let g:terminal_color_6 =  s:cyan.gui
  let g:terminal_color_7 =  s:white.gui
  let g:terminal_color_8 =  s:visual_grey.gui
  let g:terminal_color_9 =  s:dark_red.gui
  let g:terminal_color_10 = s:green.gui " No dark version
  let g:terminal_color_11 = s:dark_yellow.gui
  let g:terminal_color_12 = s:blue.gui " No dark version
  let g:terminal_color_13 = s:purple.gui " No dark version
  let g:terminal_color_14 = s:cyan.gui " No dark version
  let g:terminal_color_15 = s:comment_grey.gui
  let g:terminal_color_background = s:background.gui
  let g:terminal_color_foreground = s:foreground.gui
  " }}}

  " Neovim Diagnostics {{{
  call s:h("DiagnosticError", { "fg": s:red })
  call s:h("DiagnosticWarn", { "fg": s:yellow })
  call s:h("DiagnosticInfo", { "fg": s:blue })
  call s:h("DiagnosticHint", { "fg": s:cyan })
  call s:h("DiagnosticUnderlineError", { "fg": s:red, "gui": "underline", "cterm": "underline" })
  call s:h("DiagnosticUnderlineWarn", { "fg": s:yellow, "gui": "underline", "cterm": "underline" })
  call s:h("DiagnosticUnderlineInfo", { "fg": s:blue, "gui": "underline", "cterm": "underline" })
  call s:h("DiagnosticUnderlineHint", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })
  " }}}

  " Neovim LSP (for versions < 0.5.1) {{{
  hi link LspDiagnosticsDefaultError DiagnosticError
  hi link LspDiagnosticsDefaultWarning DiagnosticWarn
  hi link LspDiagnosticsDefaultInformation DiagnosticInfo
  hi link LspDiagnosticsDefaultHint DiagnosticHint
  hi link LspDiagnosticsUnderlineError DiagnosticUnderlineError
  hi link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn
  hi link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo
  hi link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint
  " }}}
endif

" }}}
if &t_Co >= 256
    let g:codedark_term256=1
elseif !exists("g:codedark_term256")
    let g:codedark_term256=0
endif
fun! <sid>hi(group, fg, bg, attr, sp)
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . (g:codedark_term256 ? a:fg.cterm256 : a:fg.cterm)
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . (g:codedark_term256 ? a:bg.cterm256 : a:bg.cterm)
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
  if !empty(a:sp)
    exec "hi " . a:group . " guisp=" . a:sp.gui
  endif
endfun

" ------------------
" Color definitions:
" ------------------

" Terminal colors (base16):
let s:cterm00 = "00"
let s:cterm03 = "08"
let s:cterm05 = "07"
let s:cterm07 = "15"
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"
if exists('base16colorspace') && base16colorspace == "256"
  let s:cterm01 = "18"
  let s:cterm02 = "19"
  let s:cterm04 = "20"
  let s:cterm06 = "21"
  let s:cterm09 = "16"
  let s:cterm0F = "17"
else
  let s:cterm01 = "00"
  let s:cterm02 = "08"
  let s:cterm04 = "07"
  let s:cterm06 = "07"
  let s:cterm09 = "06"
  let s:cterm0F = "03"
endif

" General appearance colors:
" (some of them may be unused)

let s:cdNone = {'gui': 'NONE', 'cterm': 'NONE', 'cterm256': 'NONE'}
let s:cdFront = {'gui': '#D4D4D4', 'cterm': s:cterm05, 'cterm256': '188'}
let s:cdBack = {'gui': '#1E1E1E', 'cterm': s:cterm00, 'cterm256': '234'}

let s:cdTabCurrent = {'gui': '#1E1E1E', 'cterm': s:cterm00, 'cterm256': '234'}
let s:cdTabOther = {'gui': '#2D2D2D', 'cterm': s:cterm01, 'cterm256': '236'}
let s:cdTabOutside = {'gui': '#252526', 'cterm': s:cterm01, 'cterm256': '235'}

let s:cdLeftDark = {'gui': '#252526', 'cterm': s:cterm01, 'cterm256': '235'}
let s:cdLeftMid = {'gui': '#373737', 'cterm': s:cterm03, 'cterm256': '237'}
let s:cdLeftLight = {'gui': '#3F3F46', 'cterm': s:cterm03, 'cterm256': '238'}

let s:cdPopupFront = {'gui': '#BBBBBB', 'cterm': s:cterm06, 'cterm256': '250'}
let s:cdPopupBack = {'gui': '#2D2D30', 'cterm': s:cterm01, 'cterm256': '236'}
let s:cdPopupHighlightBlue = {'gui': '#073655', 'cterm': s:cterm0D, 'cterm256': '24'}
let s:cdPopupHighlightGray = {'gui': '#3D3D40', 'cterm': s:cterm03, 'cterm256': '237'}

let s:cdSplitLight = {'gui': '#898989', 'cterm': s:cterm04, 'cterm256': '245'}
let s:cdSplitDark = {'gui': '#444444', 'cterm': s:cterm03, 'cterm256': '238'}
let s:cdSplitThumb = {'gui': '#424242', 'cterm': s:cterm04, 'cterm256': '238'}

let s:cdCursorDarkDark = {'gui': '#222222', 'cterm': s:cterm01, 'cterm256': '235'}
let s:cdCursorDark = {'gui': '#51504F', 'cterm': s:cterm03, 'cterm256': '239'}
let s:cdCursorLight = {'gui': '#AEAFAD', 'cterm': s:cterm04, 'cterm256': '145'}
let s:cdSelection = {'gui': '#264F78', 'cterm': s:cterm03, 'cterm256': '24'}
let s:cdLineNumber = {'gui': '#5A5A5A', 'cterm': s:cterm04, 'cterm256': '240'}

let s:cdDiffRedDark = {'gui': '#4B1818', 'cterm': s:cterm08, 'cterm256': '52'}
let s:cdDiffRedLight = {'gui': '#6F1313', 'cterm': s:cterm08, 'cterm256': '52'}
let s:cdDiffRedLightLight = {'gui': '#FB0101', 'cterm': s:cterm08, 'cterm256': '09'}
let s:cdDiffGreenDark = {'gui': '#373D29', 'cterm': s:cterm0B, 'cterm256': '237'}
let s:cdDiffGreenLight = {'gui': '#4B5632', 'cterm': s:cterm09, 'cterm256': '58'}

let s:cdSearchCurrent = {'gui': '#4B5632', 'cterm': s:cterm09, 'cterm256': '58'} 
let s:cdSearch = {'gui': '#264F78', 'cterm': s:cterm03, 'cterm256': '24'}

" Syntax colors:

if !exists("g:codedark_conservative")
    let g:codedark_conservative=0
endif

" Italicized comments
if !exists("g:codedark_italics")
    let g:codedark_italics=0
endif

let s:cdGray = {'gui': '#808080', 'cterm': s:cterm04, 'cterm256': '08'}
let s:cdViolet = {'gui': '#646695', 'cterm': s:cterm04, 'cterm256': '60'}
let s:cdBlue = {'gui': '#569CD6', 'cterm': s:cterm0D, 'cterm256': '75'}
let s:cdDarkBlue = {'gui': '#223E55', 'cterm': s:cterm0D, 'cterm256': '73'}
let s:cdLightBlue = {'gui': '#9CDCFE', 'cterm': s:cterm0C, 'cterm256': '117'}
if g:codedark_conservative | let s:cdLightBlue = s:cdFront | endif
let s:cdGreen = {'gui': '#6A9955', 'cterm': s:cterm0B, 'cterm256': '65'}
let s:cdBlueGreen = {'gui': '#4EC9B0', 'cterm': s:cterm0F, 'cterm256': '43'}
let s:cdLightGreen = {'gui': '#B5CEA8', 'cterm': s:cterm09, 'cterm256': '151'}
let s:cdRed = {'gui': '#F44747', 'cterm': s:cterm08, 'cterm256': '203'}
let s:cdOrange = {'gui': '#CE9178', 'cterm': s:cterm0F, 'cterm256': '173'}
let s:cdLightRed = {'gui': '#D16969', 'cterm': s:cterm08, 'cterm256': '167'}
if g:codedark_conservative | let s:cdLightRed = s:cdOrange | endif
let s:cdYellowOrange = {'gui': '#D7BA7D', 'cterm': s:cterm0A, 'cterm256': '179'}
let s:cdYellow = {'gui': '#DCDCAA', 'cterm': s:cterm0A, 'cterm256': '187'}
if g:codedark_conservative | let s:cdYellow = s:cdFront | endif
let s:cdPink = {'gui': '#C586C0', 'cterm': s:cterm0E, 'cterm256': '176'}
if g:codedark_conservative | let s:cdPink = s:cdBlue | endif
let s:cdSilver = {'gui': '#C0C0C0', 'cterm': s:cterm05, 'cterm256': '7'}

call <sid>hi('CmpItemAbbrDeprecated', s:cdGray, {}, 'strikethrough', {})
call <sid>hi('CmpItemAbbrMatch', s:cdBlue, {}, 'none', {})
call <sid>hi('CmpItemAbbrMatchFuzzy', s:cdBlue, {}, 'none', {})
call <sid>hi('CmpItemKindVariable', s:cdLightBlue, {}, 'none', {})
call <sid>hi('CmpItemKindInterface', s:cdLightBlue, {}, 'none', {})
call <sid>hi('CmpItemKindText', s:cdLightBlue, {}, 'none', {})
call <sid>hi('CmpItemKindFunction', s:cdPink, {}, 'none', {})
call <sid>hi('CmpItemKindMethod ', s:cdPink, {}, 'none', {})
call <sid>hi('CmpItemKindKeyword', s:cdFront, {}, 'none', {})
call <sid>hi('CmpItemKindProperty', s:cdFront, {}, 'none', {})
call <sid>hi('CmpItemKindUnit', s:cdFront, {}, 'none', {})
" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
