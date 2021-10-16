" Vim syntax file
"
" Language: Markdown Concealed Vim Syntax
" Based_On: vim-markdown v9: https://github.com/plasticboy/vim-markdown
" Original_Author: Ben Williams <benw@plasticboy.com>
" Conceal_Mods_and_General_Improvements: Kevin MacMartin <prurigro at gmail dot com>
"

" Read the HTML syntax to start with
if version < 600
    so <sfile>:p:h/html.vim
else
    runtime! syntax/html.vim
    if exists('b:current_syntax')
        unlet b:current_syntax
    endif
endif

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508|command! -nargs=+ HtmlHiLink hi link <args>|else|command! -nargs=+ HtmlHiLink hi def link <args>|endif
    command! -nargs=+ HtmlHiLink hi link <args>
else|command! -nargs=+ HtmlHiLink hi def link <args>|endif
    command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlItalic          matchgroup=mkdDelimiter start="\\\@<!\*\S\@="                          end="\S\@<=\\\@<!\*"                   keepend oneline concealends contains=mkdEscape
syn region htmlItalic          matchgroup=mkdDelimiter start="\(^\|\s\)\@<=_\|\\\@<!_\([^_]\+\s\)\@=" end="\S\@<=_\|_\S\@="                  keepend oneline concealends contains=mkdEscape
syn region htmlBold            matchgroup=mkdDelimiter start="\S\@<=\*\*\|\*\*\S\@="                  end="\S\@<=\*\*\|\*\*\S\@="            keepend oneline concealends contains=mkdEscape
syn region htmlBold            matchgroup=mkdDelimiter start="\S\@<=__\|__\S\@="                      end="\S\@<=__\|__\S\@="                keepend oneline concealends contains=mkdEscape
syn region htmlBoldItalic      matchgroup=mkdDelimiter start="\S\@<=\*\*\*\|\*\*\*\S\@="              end="\S\@<=\*\*\*\|\*\*\*\S\@="        keepend oneline concealends contains=mkdEscape
syn region htmlBoldItalic      matchgroup=mkdDelimiter start="\S\@<=___\|___\S\@="                    end="\S\@<=___\|___\S\@="              keepend oneline concealends contains=mkdEscape
syn region mkdFootnotes        matchgroup=mkdDelimiter start="\[^"                                    end="\]"
syn region mkdID               matchgroup=mkdDelimiter start="\!?\["                                  end="\]"                               contained oneline
syn region mkdURL              matchgroup=mkdDelimiter start="("                                      end=")"                                contained contains=mkdEscape,mkdURLInnerParen oneline
syn match  mkdURLInnerParen                            "([^)]*)"                                                                             contained
syn region mkdLink             matchgroup=mkdDelimiter start="\\\@<!\["                               end="\]\ze\s*[[(]"                     contains=@Spell,mkdEscape nextgroup=mkdURL,mkdID skipwhite oneline concealends cchar=→
syn match  mkdInlineURL                                /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
syn region mkdLinkDef          matchgroup=mkdDelimiter start="^ \{,3}\zs\["                           end="]:"                               oneline nextgroup=mkdLinkDefTarget skipwhite
syn region mkdLinkDefTarget                            start="<\?\zs\S" excludenl                     end="\ze[>[:space:]\n]"                contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline
syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+"+                                      end=+"+                                contained
syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+'+                                      end=+'+                                contained
syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+(+                                      end=+)+                                contained

"define Markdown groups
syn match  mkdLineContinue                             ".$"                                                                                  contained
syn match  mkdLineBreak                                /  \+$/
syn region mkdBlockquote                               start=/^\s*>/                                  end=/$/                                contains=mkdLineBreak,mkdLineContinue,@Spell
syn region mkdCode             matchgroup=mkdDelimiter start=/\(\([^\\]\|^\)\\\)\@<!`/                end=/\(\([^\\]\|^\)\\\)\@<!`/          concealends
syn region mkdCode             matchgroup=mkdDelimiter start=/\s*``[^`]*/                             end=/[^`]*``\s*/                       concealends
syn region mkdCode             matchgroup=mkdDelimiter start=/^\s*```.*$/                             end=/^\s*```\s*$/                      concealends contains=mkdCodeCfg
syn match  mkdCodeCfg                                  "{[^}]*}"                                                                             contained conceal
syn region mkdCode             matchgroup=mkdDelimiter start="<pre[^>\\]*>"                           end="</pre>"                           concealends
syn region mkdCode             matchgroup=mkdDelimiter start="<code[^>\\]*>"                          end="</code>"                          concealends
syn region mkdFootnote         matchgroup=mkdDelimiter start="\[^"                                    end="\]"
syn match  mkdCode                                     /^\s*\n\(\(\s\{8,}[^ ]\|\t\t\+[^\t]\).*\n\)\+/
syn match  mkdIndentCode                               /^\s*\n\(\(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/                                          contained
syn match  mkdListItem                                 "^\s*[-*+]\s\+"                                                                       contains=mkdListTab,mkdListBullet2
syn match  mkdListItem                                 "^\s*\d\+\.\s\+"                                                                      contains=mkdListTab
syn match  mkdListTab                                  "^\s*\*"                                                                              contained contains=mkdListBullet1
syn match  mkdListBullet1                              "\*"                                                                                  contained conceal cchar=•
syn match  mkdListBullet2                              "[-*+]"                                                                               contained conceal cchar=•
syn region mkdNonListItemBlock                         start="\n\(\_^\_$\|\s\{4,}[^ ]\|\t+[^\t]\)\@!" end="^\(\s*\([-*+]\|\d\+\.\)\s\+\)\@=" contains=@mkdNonListItem,@Spell
syn match  mkdRule                                     /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  mkdRule                                     /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  mkdRule                                     /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match  mkdRule                                     /^\s*-\{3,}$/
syn match  mkdRule                                     /^\s*\*\{3,5}$/

" HTML headings
syn region htmlH1              matchgroup=mkdDelimiter start="^\s*#"                                  end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH2              matchgroup=mkdDelimiter start="^\s*##"                                 end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH3              matchgroup=mkdDelimiter start="^\s*###"                                end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH4              matchgroup=mkdDelimiter start="^\s*####"                               end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH5              matchgroup=mkdDelimiter start="^\s*#####"                              end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH6              matchgroup=mkdDelimiter start="^\s*######"                             end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn match  htmlH1                                      /^.\+\n=\+$/                                                                          contains=@Spell
syn match  htmlH2                                      /^.\+\n-\+$/                                                                          contains=@Spell
syn match  mkdEscape                                   "\\[`\*_{}\[\]()#\+-\.\!]"                                                            contained contains=mkdEscapeChar
syn match  mkdEscapeChar                               "\\"                                                                                  contained conceal

syn cluster mkdNonListItem contains=htmlItalic,htmlBold,htmlBoldItalic,mkdFootnotes,mkdID,mkdLink,mkdLinkDef,mkdLineBreak,mkdBlockquote,mkdCode,mkdIndentCode,mkdListItem,mkdRule,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,mkdEscape

" Highlighting for Markdown groups
HtmlHiLink mkdString        String
HtmlHiLink mkdCode          String
HtmlHiLink mkdIndentCode    String
HtmlHiLink mkdEscape        Comment
HtmlHiLink mkdEscapeChar    Comment
HtmlHiLink mkdFootnote      Comment
HtmlHiLink mkdBlockquote    Comment
HtmlHiLink mkdLineContinue  Comment
HtmlHiLink mkdDelimiter     Comment
HtmlHiLink mkdListItem      Identifier
HtmlHiLink mkdRule          Identifier
HtmlHiLink mkdLineBreak     Todo
HtmlHiLink mkdFootnotes     htmlLink
HtmlHiLink mkdLink          htmlLink
HtmlHiLink mkdURL           htmlString
HtmlHiLink mkdURLInnerParen mkdURL
HtmlHiLink mkdInlineURL     htmlLink
HtmlHiLink mkdID            Identifier
HtmlHiLink mkdLinkDef       mkdID
HtmlHiLink mkdLinkDefTarget mkdURL
HtmlHiLink mkdLinkTitle     htmlString
HtmlHiLink mkdDelimiter     Delimiter

setlocal formatoptions+=r "Automatically insert bullets
setlocal formatoptions-=c "Do not automatically insert bullets when auto-wrapping with text-width
setlocal comments=b:*,b:+,b:- "Accept various markers as bullets
let b:current_syntax = "pandocmd"
delcommand HtmlHiLink

" more reasonably sized symbols that were already defined
syn match texMathSymbol '\\implies\>' containedin=ALL conceal cchar=⇒
syn match texMathSymbol '\\Leftarrow\>' containedin=ALL conceal cchar=⇐
syn match texMathSymbol '\\rightarrow' containedin=ALL conceal cchar=→
syn match texMathSymbol '\\leftarrow\>' containedin=ALL conceal cchar=←
syn match texMathSymbol '\\emptyset\>' containedin=ALL conceal cchar=Ø
syn match texMathSymbol '\\varphi\>' containedin=ALL conceal cchar=φ
syn match texMathSymbol '\\phi\>' containedin=ALL conceal cchar=Φ
syn match texMathSymbol '\\langle\s' containedin=ALL conceal cchar=⟨
syn match texMathSymbol '\s\\rangle\>' containedin=ALL conceal cchar=⟩
syn match texMathSymbol '\\\\' containedin=ALL conceal cchar=⏎

" logical symbols
syn match texMathSymbol '\\vee\>' containedin=ALL conceal cchar=∨
syn match texMathSymbol '\\wedge\>' containedin=ALL conceal cchar=∧
syn match texMathSymbol '\\neg\>' containedin=ALL conceal cchar=¬
syn match texMathSymbol '\\implies\>' containedin=ALL conceal cchar=⇒
syn match texMathSymbol '\\geq\>' containedin=ALL conceal cchar=⩾
syn match texMathSymbol '\\leq\>' containedin=ALL conceal cchar=⩽

" \mathbb characters
syn match texMathSymbol '\\mathbb{\s*A\s*}' containedin=ALL conceal cchar=𝔸
syn match texMathSymbol '\\mathbb{\s*B\s*}' containedin=ALL conceal cchar=𝔹
syn match texMathSymbol '\\mathbb{\s*C\s*}' containedin=ALL conceal cchar=ℂ
syn match texMathSymbol '\\mathbb{\s*D\s*}' containedin=ALL conceal cchar=𝔻
syn match texMathSymbol '\\mathbb{\s*E\s*}' containedin=ALL conceal cchar=𝔼
syn match texMathSymbol '\\mathbb{\s*F\s*}' containedin=ALL conceal cchar=𝔽
syn match texMathSymbol '\\mathbb{\s*G\s*}' containedin=ALL conceal cchar=𝔾
syn match texMathSymbol '\\mathbb{\s*H\s*}' containedin=ALL conceal cchar=ℍ
syn match texMathSymbol '\\mathbb{\s*I\s*}' containedin=ALL conceal cchar=𝕀
syn match texMathSymbol '\\mathbb{\s*J\s*}' containedin=ALL conceal cchar=𝕁
syn match texMathSymbol '\\mathbb{\s*K\s*}' containedin=ALL conceal cchar=𝕂
syn match texMathSymbol '\\mathbb{\s*L\s*}' containedin=ALL conceal cchar=𝕃
syn match texMathSymbol '\\mathbb{\s*M\s*}' containedin=ALL conceal cchar=𝕄
syn match texMathSymbol '\\mathbb{\s*N\s*}' containedin=ALL conceal cchar=ℕ
syn match texMathSymbol '\\mathbb{\s*O\s*}' containedin=ALL conceal cchar=𝕆
syn match texMathSymbol '\\mathbb{\s*P\s*}' containedin=ALL conceal cchar=ℙ
syn match texMathSymbol '\\mathbb{\s*Q\s*}' containedin=ALL conceal cchar=ℚ
syn match texMathSymbol '\\mathbb{\s*R\s*}' containedin=ALL conceal cchar=ℝ
syn match texMathSymbol '\\mathbb{\s*S\s*}' containedin=ALL conceal cchar=𝕊
syn match texMathSymbol '\\mathbb{\s*T\s*}' containedin=ALL conceal cchar=𝕋
syn match texMathSymbol '\\mathbb{\s*U\s*}' containedin=ALL conceal cchar=𝕌
syn match texMathSymbol '\\mathbb{\s*V\s*}' containedin=ALL conceal cchar=𝕍
syn match texMathSymbol '\\mathbb{\s*W\s*}' containedin=ALL conceal cchar=𝕎
syn match texMathSymbol '\\mathbb{\s*X\s*}' containedin=ALL conceal cchar=𝕏
syn match texMathSymbol '\\mathbb{\s*Y\s*}' containedin=ALL conceal cchar=𝕐
syn match texMathSymbol '\\mathbb{\s*Z\s*}' containedin=ALL conceal cchar=ℤ

" \mathsf characters
"syn match texMathSymbol '\\mathsf{\s*a\s*}' containedin=ALL conceal cchar=𝖺
"syn match texMathSymbol '\\mathsf{\s*b\s*}' containedin=ALL conceal cchar=𝖻
"syn match texMathSymbol '\\mathsf{\s*c\s*}' containedin=ALL conceal cchar=𝖼
"syn match texMathSymbol '\\mathsf{\s*d\s*}' containedin=ALL conceal cchar=𝖽
"syn match texMathSymbol '\\mathsf{\s*e\s*}' containedin=ALL conceal cchar=𝖾
"syn match texMathSymbol '\\mathsf{\s*f\s*}' containedin=ALL conceal cchar=𝖿
"syn match texMathSymbol '\\mathsf{\s*g\s*}' containedin=ALL conceal cchar=𝗀
"syn match texMathSymbol '\\mathsf{\s*h\s*}' containedin=ALL conceal cchar=𝗁
"syn match texMathSymbol '\\mathsf{\s*i\s*}' containedin=ALL conceal cchar=𝗂
"syn match texMathSymbol '\\mathsf{\s*j\s*}' containedin=ALL conceal cchar=𝗃
"syn match texMathSymbol '\\mathsf{\s*k\s*}' containedin=ALL conceal cchar=𝗄
"syn match texMathSymbol '\\mathsf{\s*l\s*}' containedin=ALL conceal cchar=𝗅
"syn match texMathSymbol '\\mathsf{\s*m\s*}' containedin=ALL conceal cchar=𝗆
"syn match texMathSymbol '\\mathsf{\s*n\s*}' containedin=ALL conceal cchar=𝗇
"syn match texMathSymbol '\\mathsf{\s*o\s*}' containedin=ALL conceal cchar=𝗈
"syn match texMathSymbol '\\mathsf{\s*p\s*}' containedin=ALL conceal cchar=𝗉
"syn match texMathSymbol '\\mathsf{\s*q\s*}' containedin=ALL conceal cchar=𝗊
"syn match texMathSymbol '\\mathsf{\s*r\s*}' containedin=ALL conceal cchar=𝗋
"syn match texMathSymbol '\\mathsf{\s*s\s*}' containedin=ALL conceal cchar=𝗌
"syn match texMathSymbol '\\mathsf{\s*t\s*}' containedin=ALL conceal cchar=𝗍
"syn match texMathSymbol '\\mathsf{\s*u\s*}' containedin=ALL conceal cchar=𝗎
"syn match texMathSymbol '\\mathsf{\s*v\s*}' containedin=ALL conceal cchar=𝗏
"syn match texMathSymbol '\\mathsf{\s*w\s*}' containedin=ALL conceal cchar=𝗐
"syn match texMathSymbol '\\mathsf{\s*x\s*}' containedin=ALL conceal cchar=𝗑
"syn match texMathSymbol '\\mathsf{\s*y\s*}' containedin=ALL conceal cchar=𝗒
"syn match texMathSymbol '\\mathsf{\s*z\s*}' containedin=ALL conceal cchar=𝗓
"syn match texMathSymbol '\\mathsf{\s*A\s*}' containedin=ALL conceal cchar=𝖠
"syn match texMathSymbol '\\mathsf{\s*B\s*}' containedin=ALL conceal cchar=𝖡
"syn match texMathSymbol '\\mathsf{\s*C\s*}' containedin=ALL conceal cchar=𝖢
"syn match texMathSymbol '\\mathsf{\s*D\s*}' containedin=ALL conceal cchar=𝖣
"syn match texMathSymbol '\\mathsf{\s*E\s*}' containedin=ALL conceal cchar=𝖤
"syn match texMathSymbol '\\mathsf{\s*F\s*}' containedin=ALL conceal cchar=𝖥
"syn match texMathSymbol '\\mathsf{\s*G\s*}' containedin=ALL conceal cchar=𝖦
"syn match texMathSymbol '\\mathsf{\s*H\s*}' containedin=ALL conceal cchar=𝖧
"syn match texMathSymbol '\\mathsf{\s*I\s*}' containedin=ALL conceal cchar=𝖨
"syn match texMathSymbol '\\mathsf{\s*J\s*}' containedin=ALL conceal cchar=𝖩
"syn match texMathSymbol '\\mathsf{\s*K\s*}' containedin=ALL conceal cchar=𝖪
"syn match texMathSymbol '\\mathsf{\s*L\s*}' containedin=ALL conceal cchar=𝖫
"syn match texMathSymbol '\\mathsf{\s*M\s*}' containedin=ALL conceal cchar=𝖬
"syn match texMathSymbol '\\mathsf{\s*N\s*}' containedin=ALL conceal cchar=𝖭
"syn match texMathSymbol '\\mathsf{\s*O\s*}' containedin=ALL conceal cchar=𝖮
"syn match texMathSymbol '\\mathsf{\s*P\s*}' containedin=ALL conceal cchar=𝖯
"syn match texMathSymbol '\\mathsf{\s*Q\s*}' containedin=ALL conceal cchar=𝖰
"syn match texMathSymbol '\\mathsf{\s*R\s*}' containedin=ALL conceal cchar=𝖱
"syn match texMathSymbol '\\mathsf{\s*S\s*}' containedin=ALL conceal cchar=𝖲
"syn match texMathSymbol '\\mathsf{\s*T\s*}' containedin=ALL conceal cchar=𝖳
"syn match texMathSymbol '\\mathsf{\s*U\s*}' containedin=ALL conceal cchar=𝖴
"syn match texMathSymbol '\\mathsf{\s*V\s*}' containedin=ALL conceal cchar=𝖵
"syn match texMathSymbol '\\mathsf{\s*W\s*}' containedin=ALL conceal cchar=𝖶
"syn match texMathSymbol '\\mathsf{\s*X\s*}' containedin=ALL conceal cchar=𝖷
"syn match texMathSymbol '\\mathsf{\s*Y\s*}' containedin=ALL conceal cchar=𝖸
"syn match texMathSymbol '\\mathsf{\s*Z\s*}' containedin=ALL conceal cchar=𝖹

" \mathfrak characters
"syn match texMathSymbol '\\mathfrak{\s*a\s*}' containedin=ALL conceal cchar=𝔞
"syn match texMathSymbol '\\mathfrak{\s*b\s*}' containedin=ALL conceal cchar=𝔟
"syn match texMathSymbol '\\mathfrak{\s*c\s*}' containedin=ALL conceal cchar=𝔠
"syn match texMathSymbol '\\mathfrak{\s*d\s*}' containedin=ALL conceal cchar=𝔡
"syn match texMathSymbol '\\mathfrak{\s*e\s*}' containedin=ALL conceal cchar=𝔢
"syn match texMathSymbol '\\mathfrak{\s*f\s*}' containedin=ALL conceal cchar=𝔣
"syn match texMathSymbol '\\mathfrak{\s*g\s*}' containedin=ALL conceal cchar=𝔤
"syn match texMathSymbol '\\mathfrak{\s*h\s*}' containedin=ALL conceal cchar=𝔥
"syn match texMathSymbol '\\mathfrak{\s*i\s*}' containedin=ALL conceal cchar=𝔦
"syn match texMathSymbol '\\mathfrak{\s*j\s*}' containedin=ALL conceal cchar=𝔧
"syn match texMathSymbol '\\mathfrak{\s*k\s*}' containedin=ALL conceal cchar=𝔨
"syn match texMathSymbol '\\mathfrak{\s*l\s*}' containedin=ALL conceal cchar=𝔩
"syn match texMathSymbol '\\mathfrak{\s*m\s*}' containedin=ALL conceal cchar=𝔪
"syn match texMathSymbol '\\mathfrak{\s*n\s*}' containedin=ALL conceal cchar=𝔫
"syn match texMathSymbol '\\mathfrak{\s*o\s*}' containedin=ALL conceal cchar=𝔬
"syn match texMathSymbol '\\mathfrak{\s*p\s*}' containedin=ALL conceal cchar=𝔭
"syn match texMathSymbol '\\mathfrak{\s*q\s*}' containedin=ALL conceal cchar=𝔮
"syn match texMathSymbol '\\mathfrak{\s*r\s*}' containedin=ALL conceal cchar=𝔯
"syn match texMathSymbol '\\mathfrak{\s*s\s*}' containedin=ALL conceal cchar=𝔰
"syn match texMathSymbol '\\mathfrak{\s*t\s*}' containedin=ALL conceal cchar=𝔱
"syn match texMathSymbol '\\mathfrak{\s*u\s*}' containedin=ALL conceal cchar=𝔲
"syn match texMathSymbol '\\mathfrak{\s*v\s*}' containedin=ALL conceal cchar=𝔳
"syn match texMathSymbol '\\mathfrak{\s*w\s*}' containedin=ALL conceal cchar=𝔴
"syn match texMathSymbol '\\mathfrak{\s*x\s*}' containedin=ALL conceal cchar=𝔵
"syn match texMathSymbol '\\mathfrak{\s*y\s*}' containedin=ALL conceal cchar=𝔶
"syn match texMathSymbol '\\mathfrak{\s*z\s*}' containedin=ALL conceal cchar=𝔷
"syn match texMathSymbol '\\mathfrak{\s*A\s*}' containedin=ALL conceal cchar=𝔄
"syn match texMathSymbol '\\mathfrak{\s*B\s*}' containedin=ALL conceal cchar=𝔅
"syn match texMathSymbol '\\mathfrak{\s*C\s*}' containedin=ALL conceal cchar=ℭ
"syn match texMathSymbol '\\mathfrak{\s*D\s*}' containedin=ALL conceal cchar=𝔇
"syn match texMathSymbol '\\mathfrak{\s*E\s*}' containedin=ALL conceal cchar=𝔈
"syn match texMathSymbol '\\mathfrak{\s*F\s*}' containedin=ALL conceal cchar=𝔉
"syn match texMathSymbol '\\mathfrak{\s*G\s*}' containedin=ALL conceal cchar=𝔊
"syn match texMathSymbol '\\mathfrak{\s*H\s*}' containedin=ALL conceal cchar=ℌ
"syn match texMathSymbol '\\mathfrak{\s*I\s*}' containedin=ALL conceal cchar=ℑ
"syn match texMathSymbol '\\mathfrak{\s*J\s*}' containedin=ALL conceal cchar=𝔍
"syn match texMathSymbol '\\mathfrak{\s*K\s*}' containedin=ALL conceal cchar=𝔎
"syn match texMathSymbol '\\mathfrak{\s*L\s*}' containedin=ALL conceal cchar=𝔏
"syn match texMathSymbol '\\mathfrak{\s*M\s*}' containedin=ALL conceal cchar=𝔐
"syn match texMathSymbol '\\mathfrak{\s*N\s*}' containedin=ALL conceal cchar=𝔑
"syn match texMathSymbol '\\mathfrak{\s*O\s*}' containedin=ALL conceal cchar=𝔒
"syn match texMathSymbol '\\mathfrak{\s*P\s*}' containedin=ALL conceal cchar=𝔓
"syn match texMathSymbol '\\mathfrak{\s*Q\s*}' containedin=ALL conceal cchar=𝔔
"syn match texMathSymbol '\\mathfrak{\s*R\s*}' containedin=ALL conceal cchar=ℜ
"syn match texMathSymbol '\\mathfrak{\s*S\s*}' containedin=ALL conceal cchar=𝔖
"syn match texMathSymbol '\\mathfrak{\s*T\s*}' containedin=ALL conceal cchar=𝔗
"syn match texMathSymbol '\\mathfrak{\s*U\s*}' containedin=ALL conceal cchar=𝔘
"syn match texMathSymbol '\\mathfrak{\s*V\s*}' containedin=ALL conceal cchar=𝔙
"syn match texMathSymbol '\\mathfrak{\s*W\s*}' containedin=ALL conceal cchar=𝔚
"syn match texMathSymbol '\\mathfrak{\s*X\s*}' containedin=ALL conceal cchar=𝔛
"syn match texMathSymbol '\\mathfrak{\s*Y\s*}' containedin=ALL conceal cchar=𝔜
"syn match texMathSymbol '\\mathfrak{\s*Z\s*}' containedin=ALL conceal cchar=ℨ

" \mathcal characters
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*A\s*}' containedin=ALL conceal cchar=𝓐
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*B\s*}' containedin=ALL conceal cchar=𝓑
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*C\s*}' containedin=ALL conceal cchar=𝓒
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*D\s*}' containedin=ALL conceal cchar=𝓓
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*E\s*}' containedin=ALL conceal cchar=𝓔
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*F\s*}' containedin=ALL conceal cchar=𝓕
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*G\s*}' containedin=ALL conceal cchar=𝓖
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*H\s*}' containedin=ALL conceal cchar=𝓗
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*I\s*}' containedin=ALL conceal cchar=𝓘
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*J\s*}' containedin=ALL conceal cchar=𝓙
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*K\s*}' containedin=ALL conceal cchar=𝓚
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*L\s*}' containedin=ALL conceal cchar=𝓛
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*M\s*}' containedin=ALL conceal cchar=𝓜
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*N\s*}' containedin=ALL conceal cchar=𝓝
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*O\s*}' containedin=ALL conceal cchar=𝓞
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*P\s*}' containedin=ALL conceal cchar=𝓟
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*Q\s*}' containedin=ALL conceal cchar=𝓠
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*R\s*}' containedin=ALL conceal cchar=𝓡
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*S\s*}' containedin=ALL conceal cchar=𝓢
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*T\s*}' containedin=ALL conceal cchar=𝓣
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*U\s*}' containedin=ALL conceal cchar=𝓤
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*V\s*}' containedin=ALL conceal cchar=𝓥
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*W\s*}' containedin=ALL conceal cchar=𝓦
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*X\s*}' containedin=ALL conceal cchar=𝓧
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*Y\s*}' containedin=ALL conceal cchar=𝓨
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*Z\s*}' containedin=ALL conceal cchar=𝓩

syn match texSpecialChar '\\#' containedin=ALL conceal cchar=#

syn match texStatement '``' containedin=ALL conceal cchar=“
syn match texStatement '\'\'' containedin=ALL conceal cchar=”
syn match texStatement '\\item\>' containedin=ALL conceal cchar=•
syn match texStatement '\\ldots' containedin=ALL conceal cchar=…
syn match texStatement '\\quad' containedin=ALL conceal cchar=   
syn match texStatement '\\qquad' containedin=ALL conceal cchar=    
"syn match texStatement '\\\[' containedin=ALL conceal cchar=⟦
"syn match texStatement '\\\]' containedin=ALL conceal cchar=⟧
syn match texDelimiter '\\{' containedin=ALL conceal cchar={
syn match texDelimiter '\\}' containedin=ALL conceal cchar=}
syn match texMathSymbol '\\setminus\>' containedin=ALL conceal cchar=\
syn match texMathSymbol '\\coloneqq\>' containedin=ALL conceal cchar=≔
syn match texMathSymbol '\\colon\>' containedin=ALL conceal cchar=:
syn match texMathSymbol '\\:' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\;' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\,' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\ ' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\quad' containedin=ALL conceal cchar=  
syn match texMathSymbol '\\qquad' containedin=ALL conceal cchar=    
syn match texMathSymbol '\\sqrt' containedin=ALL conceal cchar=√
syn match texMathSymbol '\\sqrt\[3]' containedin=ALL conceal cchar=∛
syn match texMathSymbol '\\sqrt\[4]' containedin=ALL conceal cchar=∜
syn match texMathSymbol '\\\!' containedin=ALL conceal
syn match texMathSymbol '\\therefore' containedin=ALL conceal cchar=∴
syn match texMathSymbol '\\because' containedin=ALL conceal cchar=∵

if !exists('g:tex_conceal_frac')
  let g:tex_conceal_frac = 0
endif
if g:tex_conceal_frac == 1
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(2\|{2}\)' containedin=ALL conceal cchar=½
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(3\|{3}\)' containedin=ALL conceal cchar=⅓
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(2\|{2}\)\(3\|{3}\)' containedin=ALL conceal cchar=⅔
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(4\|{4}\)' containedin=ALL conceal cchar=¼
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(5\|{5}\)' containedin=ALL conceal cchar=⅕
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(2\|{2}\)\(5\|{5}\)' containedin=ALL conceal cchar=⅖
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(3\|{3}\)\(5\|{5}\)' containedin=ALL conceal cchar=⅗
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(4\|{4}\)\(5\|{5}\)' containedin=ALL conceal cchar=⅘
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(6\|{6}\)' containedin=ALL conceal cchar=⅙
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(5\|{5}\)\(6\|{6}\)' containedin=ALL conceal cchar=⅚
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(8\|{8}\)' containedin=ALL conceal cchar=⅛
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(3\|{3}\)\(8\|{8}\)' containedin=ALL conceal cchar=⅜
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(5\|{5}\)\(8\|{8}\)' containedin=ALL conceal cchar=⅝
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(7\|{7}\)\(8\|{8}\)' containedin=ALL conceal cchar=⅞
end

" hide \text delimiter etc inside math mode
"if !exists("g:tex_nospell") || !g:tex_nospell
syn region texMathText matchgroup=texStatement start='\\\%(\%(inter\)\=mathrm\)\s*{'     end='}' concealends keepend contains=@texFoldGroup containedin=ALL
syn region texMathText matchgroup=texStatement start='\\\%(\%(inter\)\=text\|mbox\)\s*{' end='}' concealends keepend contains=@texFoldGroup,@Spell containedin=ALL
"else
"syn region texMathText matchgroup=texStatement start='\\\%(\%(inter\)\=text\|mbox\|mathrm\)\s*{' end='}' concealends keepend contains=@texFoldGroup containedin=texMathMatcher
"endif

syn region texBoldMathText  matchgroup=texStatement start='\\\%(mathbf\|bm\|symbf\|pmb\){' end='}' concealends contains=@texMathZoneGroup containedin=ALL
syn cluster texMathZoneGroup add=texBoldMathText

syn region texBoldItalStyle matchgroup=texTypeStyle start="\\emph\s*{" end="}" concealends contains=@texItalGroup
syn region texItalStyle  matchgroup=texTypeStyle start="\\emph\s*{" end="}" concealends contains=@texItalGroup
syn region texMatcher matchgroup=texTypeStyle start="\\underline{" end="}" concealends keepend containedin=ALL

hi texBoldMathText cterm=bold gui=bold
hi texUnderStyle cterm=underline gui=underline
match texUnderStyle /\\\%(underline\|uline\){\zs\(.\([^\\]}\)\@<!\)\+\ze}/

" set ambiwidth=single

" Simple number super/sub-scripts

if !exists("g:tex_superscripts")
  let s:tex_superscripts= '[0-9a-zA-W.,:;+-<>/()=]'
else
  let s:tex_superscripts= g:tex_superscripts
endif
if !exists("g:tex_subscripts")
  let s:tex_subscripts= "[0-9aeijoruvx,+-/().]"
else
  let s:tex_subscripts= g:tex_subscripts
endif

" s:SuperSub:
fun! s:SuperSub(leader, pat, cchar)
  if a:pat =~# '^\\' || (a:leader == '\^' && a:pat =~# s:tex_superscripts) || (a:leader == '_' && a:pat =~# s:tex_subscripts)
    exe "syn match texMathSymbol '".a:leader.'\%('.a:pat.'\|{\s*'.a:pat.'\s*}\)'."' containedin=ALL conceal cchar=".a:cchar
  endif
endfun

call s:SuperSub('\^','0','⁰')
call s:SuperSub('\^','1','¹')
call s:SuperSub('\^','2','²')
call s:SuperSub('\^','3','³')
call s:SuperSub('\^','4','⁴')
call s:SuperSub('\^','5','⁵')
call s:SuperSub('\^','6','⁶')
call s:SuperSub('\^','7','⁷')
call s:SuperSub('\^','8','⁸')
call s:SuperSub('\^','9','⁹')
call s:SuperSub('\^','a','ᵃ')
call s:SuperSub('\^','b','ᵇ')
call s:SuperSub('\^','c','ᶜ')
call s:SuperSub('\^','d','ᵈ')
call s:SuperSub('\^','e','ᵉ')
call s:SuperSub('\^','f','ᶠ')
call s:SuperSub('\^','g','ᵍ')
call s:SuperSub('\^','h','ʰ')
call s:SuperSub('\^','i','ⁱ')
call s:SuperSub('\^','j','ʲ')
call s:SuperSub('\^','k','ᵏ')
call s:SuperSub('\^','l','ˡ')
call s:SuperSub('\^','m','ᵐ')
call s:SuperSub('\^','n','ⁿ')
call s:SuperSub('\^','o','ᵒ')
call s:SuperSub('\^','p','ᵖ')
call s:SuperSub('\^','r','ʳ')
call s:SuperSub('\^','s','ˢ')
call s:SuperSub('\^','t','ᵗ')
call s:SuperSub('\^','u','ᵘ')
call s:SuperSub('\^','v','ᵛ')
call s:SuperSub('\^','w','ʷ')
call s:SuperSub('\^','x','ˣ')
call s:SuperSub('\^','y','ʸ')
call s:SuperSub('\^','z','ᶻ')
call s:SuperSub('\^','A','ᴬ')
call s:SuperSub('\^','B','ᴮ')
call s:SuperSub('\^','D','ᴰ')
call s:SuperSub('\^','E','ᴱ')
call s:SuperSub('\^','G','ᴳ')
call s:SuperSub('\^','H','ᴴ')
call s:SuperSub('\^','I','ᴵ')
call s:SuperSub('\^','J','ᴶ')
call s:SuperSub('\^','K','ᴷ')
call s:SuperSub('\^','L','ᴸ')
call s:SuperSub('\^','M','ᴹ')
call s:SuperSub('\^','N','ᴺ')
call s:SuperSub('\^','O','ᴼ')
call s:SuperSub('\^','P','ᴾ')
call s:SuperSub('\^','R','ᴿ')
call s:SuperSub('\^','T','ᵀ')
call s:SuperSub('\^','U','ᵁ')
call s:SuperSub('\^','W','ᵂ')
call s:SuperSub('\^','+','⁺')
call s:SuperSub('\^','-','⁻')
call s:SuperSub('\^','<','˂')
call s:SuperSub('\^','>','˃')
call s:SuperSub('\^','/','ˊ')
call s:SuperSub('\^','(','⁽')
call s:SuperSub('\^',')','⁾')
call s:SuperSub('\^','\.','˙')
call s:SuperSub('\^','=','˭')
call s:SuperSub('\^','\\alpha','ᵅ')
call s:SuperSub('\^','\\beta','ᵝ')
call s:SuperSub('\^','\\gamma','ᵞ')
call s:SuperSub('\^','\\delta','ᵟ')
call s:SuperSub('\^','\\epsilon','ᵋ')
call s:SuperSub('\^','\\theta','ᶿ')
call s:SuperSub('\^','\\iota','ᶥ')
call s:SuperSub('\^','\\Phi','ᶲ')
call s:SuperSub('\^','\\varphi','ᵠ')
call s:SuperSub('\^','\\chi','ᵡ')

syn match texMathSymbol '\^\%(\*\|\\ast\|\\star\|{\s*\\\%(ast\|star\)\s*}\)' contained conceal cchar=˟
syn match texMathSymbol '\^{\s*-1\s*}' contained conceal contains=texSuperscripts
syn match texMathSymbol '\^\%(\\math\%(rm\|sf\){\s*T\s*}\|{\s*\\math\%(rm\|sf\){\s*T\s*}\s*}\)' contained conceal contains=texSuperscripts
syn match texMathSymbol '\^\%(\\math\%(rm\|sf\){\s*-T\s*}\|{\s*\\math\%(rm\|sf\){\s*-T\s*}\s*}\|{\s*-\s*\\math\%(rm\|sf\){\s*T\s*}\s*}\)' contained conceal contains=texSuperscripts
syn match texSuperscripts '1' contained conceal cchar=¹
syn match texSuperscripts '-' contained conceal cchar=⁻
syn match texSuperscripts 'T' contained conceal cchar=ᵀ

call s:SuperSub('_','0','₀')
call s:SuperSub('_','1','₁')
call s:SuperSub('_','2','₂')
call s:SuperSub('_','3','₃')
call s:SuperSub('_','4','₄')
call s:SuperSub('_','5','₅')
call s:SuperSub('_','6','₆')
call s:SuperSub('_','7','₇')
call s:SuperSub('_','8','₈')
call s:SuperSub('_','9','₉')
call s:SuperSub('_','a','ₐ')
call s:SuperSub('_','e','ₑ')
call s:SuperSub('_','h','ₕ')
call s:SuperSub('_','i','ᵢ')
call s:SuperSub('_','j','ⱼ')
call s:SuperSub('_','k','ₖ')
call s:SuperSub('_','l','ₗ')
call s:SuperSub('_','m','ₘ')
call s:SuperSub('_','n','ₙ')
call s:SuperSub('_','o','ₒ')
call s:SuperSub('_','p','ₚ')
call s:SuperSub('_','r','ᵣ')
call s:SuperSub('_','s','ₛ')
call s:SuperSub('_','t','ₜ')
call s:SuperSub('_','u','ᵤ')
call s:SuperSub('_','v','ᵥ')
call s:SuperSub('_','x','ₓ')
call s:SuperSub('_','+','₊')
call s:SuperSub('_','-','₋')
call s:SuperSub('_','/','ˏ')
call s:SuperSub('_','(','₍')
call s:SuperSub('_',')','₎')
call s:SuperSub('_','\\beta','ᵦ')
call s:SuperSub('_','\\rho','ᵨ')
call s:SuperSub('_','\\phi','ᵩ')
call s:SuperSub('_','\\gamma','ᵧ')
call s:SuperSub('_','\\chi','ᵪ')

"Custom
syn match texMathSymbol '\\forall\s' containedin=ALL conceal cchar=∀
syn match texMathSymbol '\\exists\s' containedin=ALL conceal cchar=∃
syn match texMathSymbol '\\equiv\s' containedin=ALL conceal cchar=≡
syn match texMathSymbol '\\prod\s' containedin=ALL conceal cchar=∏
syn match texMathSymbol '\\Pi\s' containedin=ALL conceal cchar=∏
syn match texMathSymbol '\\Sigma\s' containedin=ALL conceal cchar=Σ
syn match texMathSymbol '\~' containedin=ALL conceal cchar= 
syn match texMathSymbol '\$' containedin=ALL conceal cchar= 
"syn match texMathSymbol '\\text' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\triangleright\s' containedin=ALL conceal cchar=▹
syn match texMathSymbol '\\square' containedin=ALL conceal cchar=☐
syn match texMathSymbol '\\cdot' containedin=ALL conceal cchar=⋅
syn match texMathSymbol '\\uparrow' containedin=ALL conceal cchar=↑
syn match texMathSymbol '\\ne ' containedin=ALL conceal cchar=≠
syn match texMathSymbol '\\concat' containedin=ALL conceal cchar=⧺
syn match texMathSymbol '\\in ' containedin=ALL conceal cchar=∈
syn match texMathSymbol '\\infty' containedin=ALL conceal cchar=∞
syn match texMathSymbol '\\prec' containedin=ALL conceal cchar=≺
syn match texMathSymbol '\\Brackets' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\ell' containedin=ALL conceal cchar=ℓ
syn match texMathSymbol '\\sigma' containedin=ALL conceal cchar=σ
syn match texMathSymbol '\\mapsto' containedin=ALL conceal cchar=↦
