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
syn region mkdLink             matchgroup=mkdDelimiter start="\\\@<!\["                               end="\]\ze\s*[[(]"                     contains=@Spell,mkdEscape nextgroup=mkdURL,mkdID skipwhite oneline concealends cchar=???
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
syn match  mkdListBullet1                              "\*"                                                                                  contained conceal cchar=???
syn match  mkdListBullet2                              "[-*+]"                                                                               contained conceal cchar=???
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
syn match texMathSymbol '\\implies\>' containedin=ALL conceal cchar=???
"syn match texMathSymbol '\\Leftarrow\>' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\rightarrow' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\leftarrow' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\emptyset\>' containedin=ALL conceal cchar=??
syn match texMathSymbol '\\varphi\>' containedin=ALL conceal cchar=??
syn match texMathSymbol '\\phi\>' containedin=ALL conceal cchar=??
syn match texMathSymbol '\\langle\s' containedin=ALL conceal cchar=???
syn match texMathSymbol '\s\\rangle\>' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\\\' containedin=ALL conceal cchar=???

" logical symbols
syn match texMathSymbol '\\vee\>' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\wedge\>' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\neg\>' containedin=ALL conceal cchar=??
syn match texMathSymbol '\\implies\>' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\ge\>' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\le\>' containedin=ALL conceal cchar=???

" \mathbb characters
syn match texMathSymbol '\\mathbb{\s*A\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*B\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*C\s*}' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\mathbb{\s*D\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*E\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*F\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*G\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*H\s*}' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\mathbb{\s*I\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*J\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*K\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*L\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*M\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*N\s*}' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\mathbb{\s*O\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*P\s*}' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\mathbb{\s*Q\s*}' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\mathbb{\s*R\s*}' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\mathbb{\s*S\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*T\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*U\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*V\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*W\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*X\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*Y\s*}' containedin=ALL conceal cchar=????
syn match texMathSymbol '\\mathbb{\s*Z\s*}' containedin=ALL conceal cchar=???

" \mathsf characters
"syn match texMathSymbol '\\mathsf{\s*a\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*b\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*c\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*d\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*e\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*f\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*g\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*h\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*i\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*j\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*k\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*l\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*m\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*n\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*o\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*p\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*q\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*r\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*s\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*t\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*u\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*v\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*w\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*x\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*y\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*z\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*A\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*B\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*C\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*D\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*E\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*F\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*G\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*H\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*I\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*J\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*K\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*L\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*M\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*N\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*O\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*P\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*Q\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*R\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*S\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*T\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*U\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*V\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*W\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*X\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*Y\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathsf{\s*Z\s*}' containedin=ALL conceal cchar=????

" \mathfrak characters
"syn match texMathSymbol '\\mathfrak{\s*a\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*b\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*c\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*d\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*e\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*f\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*g\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*h\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*i\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*j\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*k\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*l\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*m\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*n\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*o\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*p\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*q\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*r\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*s\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*t\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*u\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*v\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*w\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*x\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*y\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*z\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*A\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*B\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*C\s*}' containedin=ALL conceal cchar=???
"syn match texMathSymbol '\\mathfrak{\s*D\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*E\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*F\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*G\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*H\s*}' containedin=ALL conceal cchar=???
"syn match texMathSymbol '\\mathfrak{\s*I\s*}' containedin=ALL conceal cchar=???
"syn match texMathSymbol '\\mathfrak{\s*J\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*K\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*L\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*M\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*N\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*O\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*P\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*Q\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*R\s*}' containedin=ALL conceal cchar=???
"syn match texMathSymbol '\\mathfrak{\s*S\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*T\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*U\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*V\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*W\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*X\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*Y\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\mathfrak{\s*Z\s*}' containedin=ALL conceal cchar=???

" \mathcal characters
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*A\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*B\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*C\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*D\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*E\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*F\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*G\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*H\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*I\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*J\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*K\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*L\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*M\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*N\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*O\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*P\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*Q\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*R\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*S\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*T\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*U\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*V\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*W\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*X\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*Y\s*}' containedin=ALL conceal cchar=????
"syn match texMathSymbol '\\math\%(scr\|cal\){\s*Z\s*}' containedin=ALL conceal cchar=????

syn match texSpecialChar '\\#' containedin=ALL conceal cchar=#

syn match texStatement '``' containedin=ALL conceal cchar=???
syn match texStatement '\'\'' containedin=ALL conceal cchar=???
syn match texStatement '\\item\>' containedin=ALL conceal cchar=???
syn match texStatement '\\ldots' containedin=ALL conceal cchar=???
syn match texStatement '\\quad' containedin=ALL conceal cchar=   
syn match texStatement '\\qquad' containedin=ALL conceal cchar=    
"syn match texStatement '\\\[' containedin=ALL conceal cchar=???
"syn match texStatement '\\\]' containedin=ALL conceal cchar=???
syn match texDelimiter '\\{' containedin=ALL conceal cchar={
syn match texDelimiter '\\}' containedin=ALL conceal cchar=}
syn match texMathSymbol '\\setminus\>' containedin=ALL conceal cchar=\
syn match texMathSymbol '\\coloneqq\>' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\colon\>' containedin=ALL conceal cchar=:
syn match texMathSymbol '\\:' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\;' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\,' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\ ' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\quad' containedin=ALL conceal cchar=  
syn match texMathSymbol '\\qquad' containedin=ALL conceal cchar=    
syn match texMathSymbol '\\sqrt' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\sqrt\[3]' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\sqrt\[4]' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\\!' containedin=ALL conceal
syn match texMathSymbol '\\therefore' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\because' containedin=ALL conceal cchar=???

if !exists('g:tex_conceal_frac')
  let g:tex_conceal_frac = 0
endif
if g:tex_conceal_frac == 1
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(2\|{2}\)' containedin=ALL conceal cchar=??
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(3\|{3}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(2\|{2}\)\(3\|{3}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(4\|{4}\)' containedin=ALL conceal cchar=??
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(5\|{5}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(2\|{2}\)\(5\|{5}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(3\|{3}\)\(5\|{5}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(4\|{4}\)\(5\|{5}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(6\|{6}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(5\|{5}\)\(6\|{6}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(8\|{8}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(3\|{3}\)\(8\|{8}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(5\|{5}\)\(8\|{8}\)' containedin=ALL conceal cchar=???
  syn match texMathSymbol '\\\(\(d\|t\)\|\)frac\(7\|{7}\)\(8\|{8}\)' containedin=ALL conceal cchar=???
end

" hide \text delimiter etc inside math mode
"if !exists("g:tex_nospell") || !g:tex_nospell
syn region texMathText matchgroup=texStatement start='\\\%(\%(inter\)\=mathrm\)\s*{'     end='}' concealends keepend contains=@texFoldGroup containedin=ALL
syn region texMathText matchgroup=texStatement start='\\\%(\%(inter\)\=text\|mbox\)\s*{' end='}' concealends keepend contains=@texFoldGroup,@Spell containedin=ALL
"else
"syn region texMathText matchgroup=texStatement start='\\\%(\%(inter\)\=text\|mbox\|mathrm\)\s*{' end='}' concealends keepend contains=@texFoldGroup containedin=texMathMatcher
"endif

syn region texBoldMathText  matchgroup=texStatement start='\\\%(mathbf\|bm\|symbf\|pmb\){' end='}' concealends contains=@texMathZoneGroup containedin=ALL
syn region texBoldText  matchgroup=texStatement start='\\textbf{' end='}' concealends contains=@texMathZoneGroup containedin=ALL
syn cluster texMathZoneGroup add=texBoldMathText

syn region texBoldItalStyle matchgroup=texTypeStyle start="\\emph\s*{" end="}" concealends contains=@texItalGroup
syn region texItalStyle  matchgroup=texTypeStyle start="\\emph\s*{" end="}" concealends contains=@texItalGroup
syn region texMatcher matchgroup=texTypeStyle start="\\underline{" end="}" concealends keepend containedin=ALL

hi texBoldMathText cterm=bold gui=bold
hi texBoldText cterm=bold gui=bold ctermfg=blue 
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

call s:SuperSub('\^','0','???')
call s:SuperSub('\^','1','??')
call s:SuperSub('\^','2','??')
call s:SuperSub('\^','3','??')
call s:SuperSub('\^','4','???')
call s:SuperSub('\^','5','???')
call s:SuperSub('\^','6','???')
call s:SuperSub('\^','7','???')
call s:SuperSub('\^','8','???')
call s:SuperSub('\^','9','???')
call s:SuperSub('\^','a','???')
call s:SuperSub('\^','b','???')
call s:SuperSub('\^','c','???')
call s:SuperSub('\^','d','???')
call s:SuperSub('\^','e','???')
call s:SuperSub('\^','f','???')
call s:SuperSub('\^','g','???')
call s:SuperSub('\^','h','??')
call s:SuperSub('\^','i','???')
call s:SuperSub('\^','j','??')
call s:SuperSub('\^','k','???')
call s:SuperSub('\^','l','??')
call s:SuperSub('\^','m','???')
call s:SuperSub('\^','n','???')
call s:SuperSub('\^','o','???')
call s:SuperSub('\^','p','???')
call s:SuperSub('\^','r','??')
call s:SuperSub('\^','s','??')
call s:SuperSub('\^','t','???')
call s:SuperSub('\^','u','???')
call s:SuperSub('\^','v','???')
call s:SuperSub('\^','w','??')
call s:SuperSub('\^','x','??')
call s:SuperSub('\^','y','??')
call s:SuperSub('\^','z','???')
call s:SuperSub('\^','A','???')
call s:SuperSub('\^','B','???')
call s:SuperSub('\^','D','???')
call s:SuperSub('\^','E','???')
call s:SuperSub('\^','G','???')
call s:SuperSub('\^','H','???')
call s:SuperSub('\^','I','???')
call s:SuperSub('\^','J','???')
call s:SuperSub('\^','K','???')
call s:SuperSub('\^','L','???')
call s:SuperSub('\^','M','???')
call s:SuperSub('\^','N','???')
call s:SuperSub('\^','O','???')
call s:SuperSub('\^','P','???')
call s:SuperSub('\^','R','???')
call s:SuperSub('\^','T','???')
call s:SuperSub('\^','U','???')
call s:SuperSub('\^','W','???')
call s:SuperSub('\^','+','???')
call s:SuperSub('\^','-','???')
call s:SuperSub('\^','<','??')
call s:SuperSub('\^','>','??')
call s:SuperSub('\^','/','??')
call s:SuperSub('\^','(','???')
call s:SuperSub('\^',')','???')
call s:SuperSub('\^','\.','??')
call s:SuperSub('\^','=','??')
call s:SuperSub('\^','\\alpha','???')
call s:SuperSub('\^','\\beta','???')
call s:SuperSub('\^','\\gamma','???')
call s:SuperSub('\^','\\delta','???')
call s:SuperSub('\^','\\epsilon','???')
call s:SuperSub('\^','\\theta','???')
call s:SuperSub('\^','\\iota','???')
call s:SuperSub('\^','\\Phi','???')
call s:SuperSub('\^','\\varphi','???')
call s:SuperSub('\^','\\chi','???')

syn match texMathSymbol '\^\%(\*\|\\ast\|\\star\|{\s*\\\%(ast\|star\)\s*}\)' contained conceal cchar=??
syn match texMathSymbol '\^{\s*-1\s*}' contained conceal contains=texSuperscripts
syn match texMathSymbol '\^\%(\\math\%(rm\|sf\){\s*T\s*}\|{\s*\\math\%(rm\|sf\){\s*T\s*}\s*}\)' contained conceal contains=texSuperscripts
syn match texMathSymbol '\^\%(\\math\%(rm\|sf\){\s*-T\s*}\|{\s*\\math\%(rm\|sf\){\s*-T\s*}\s*}\|{\s*-\s*\\math\%(rm\|sf\){\s*T\s*}\s*}\)' contained conceal contains=texSuperscripts
syn match texSuperscripts '1' contained conceal cchar=??
syn match texSuperscripts '-' contained conceal cchar=???
syn match texSuperscripts 'T' contained conceal cchar=???

call s:SuperSub('_','0','???')
call s:SuperSub('_','1','???')
call s:SuperSub('_','2','???')
call s:SuperSub('_','3','???')
call s:SuperSub('_','4','???')
call s:SuperSub('_','5','???')
call s:SuperSub('_','6','???')
call s:SuperSub('_','7','???')
call s:SuperSub('_','8','???')
call s:SuperSub('_','9','???')
call s:SuperSub('_','a','???')
call s:SuperSub('_','e','???')
call s:SuperSub('_','h','???')
call s:SuperSub('_','i','???')
call s:SuperSub('_','j','???')
call s:SuperSub('_','k','???')
call s:SuperSub('_','l','???')
call s:SuperSub('_','m','???')
call s:SuperSub('_','n','???')
call s:SuperSub('_','o','???')
call s:SuperSub('_','p','???')
call s:SuperSub('_','r','???')
call s:SuperSub('_','s','???')
call s:SuperSub('_','t','???')
call s:SuperSub('_','u','???')
call s:SuperSub('_','v','???')
call s:SuperSub('_','x','???')
call s:SuperSub('_','+','???')
call s:SuperSub('_','-','???')
call s:SuperSub('_','/','??')
call s:SuperSub('_','(','???')
call s:SuperSub('_',')','???')
call s:SuperSub('_','\\beta','???')
call s:SuperSub('_','\\rho','???')
call s:SuperSub('_','\\phi','???')
call s:SuperSub('_','\\gamma','???')
call s:SuperSub('_','\\chi','???')

"Custom
syn match texMathSymbol '\\forall\s' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\exists\s' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\equiv\s' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\prod\s' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\Pi\s' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\Sigma\s' containedin=ALL conceal cchar=??
syn match texMathSymbol '\~' containedin=ALL conceal cchar= 
syn match texMathSymbol '\$' containedin=ALL conceal cchar= 
"syn match texMathSymbol '\\text' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\triangleright\s' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\square' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\cdot' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\uparrow' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\ne ' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\concat' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\in ' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\infty' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\prec' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\Brackets' containedin=ALL conceal cchar= 
syn match texMathSymbol '\\ell' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\sigma' containedin=ALL conceal cchar=??
syn match texMathSymbol '\\mapsto' containedin=ALL conceal cchar=???
syn match texMathSymbol '\\neq' containedin=ALL conceal cchar=???
