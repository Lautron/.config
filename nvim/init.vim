set number
set mouse=a
set numberwidth=2
"set clipboard=unnamed
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
set conceallevel=2
set nrformats+=alpha
set cursorline
set linebreak
set undofile
set foldenable "Enable folding

:filetype on

"Install vim plug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:ale_disable_lsp = 1

call plug#begin('~/.nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin' |
      \ Plug 'ryanoasis/vim-devicons'

Plug 'christoomey/vim-tmux-navigator'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories = ['~/.nvim/plugged/vim-snippets/UltiSnips']

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'markdown'}
let g:tex_flavor = 'latex'
let g:tex_conceal="abdgm"

Plug 'honza/vim-snippets'
Plug 'mechatroner/rainbow_csv'
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-autoformat/vim-autoformat'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

Plug 'sirtaj/vim-openscad'
Plug 'masukomi/vim-markdown-folding'

Plug 'sennavanhoek/a64asm-vim'
Plug 'chrisbra/Colorizer'

Plug 'dense-analysis/ale'

Plug 'yaegassy/coc-tailwindcss3', {'do': 'yarn install --frozen-lockfile'}

call plug#end()
let s:hidden_all = 1
set noshowmode
set laststatus=0
set noshowcmd
function! ToggleHiddenAll()
  if s:hidden_all  == 0
    let s:hidden_all = 1
    set noshowmode
    set laststatus=0
    "set noshowcmd
  else
    let s:hidden_all = 0
    "set showmode
    set laststatus=2
    set statusline=%f
    "set showcmd
  endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>
let mapleader = " "
let NERDTreeQuitOnOpen=1
function! RunPython(...)
  ":silent 
  let ex_command = "! alacritty -e fish -C 'venv &> /dev/null & echo -e \"Running %\\n\" & python % " .. join(a:000, ' ') .. "' &"
  silent  execute ex_command
endfunction
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! QbOpen(engine)
  let ex_command = "! qutebrowser :'open -w " .. a:engine .. " " .. s:get_visual_selection() .. "'"
  execute ex_command
endfunction
command! -nargs=* -complete=file RunPython call RunPython(<f-args>)
command! -range OpenMath call QbOpen('sym') <bar> call QbOpen('wa')
"command! -range OpenSym call QbOpen('sym')
"command! -range OpenWa call QbOpen('wa')
nmap <silent> ,/ :nohlsearch<CR>
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>rp :w <bar> :RunPython
nmap <Leader>mc :w <bar> :! make clean<CR>
nmap <Leader>mr :w <bar> :vsplit <bar> term make run<CR>
nmap <Leader>mv :w <bar> :vsplit <bar> term make val<CR>
nmap <Leader>mm :w <bar> :! make<CR>
nmap <Leader>cc :w <bar> :! gcc -Wall -Werror -Wextra -pedantic -std=c99 -g % -o %< <CR>
nmap <Leader>r+ :w <bar> :! g++ -g -O2 -std=gnu++17 -static -o %< % <CR>
nmap <Leader>c+ :w <bar> :! g++ -std=c++11 -g -O2 -Wconversion -Wshadow -Wall -Wextra -D_GLIBCXX_DEBUG -o %< % <CR>
nmap <Leader>cl :w <bar> :!pandoc -f markdown -t latex "%" -o "%:r.pdf"<CR>
nmap <Leader>p "+p<CR>
vmap <Leader>y "+y<CR>
nmap <Leader>op :!zathura '%<'.pdf&;disown<cr>:redraw!<cr>
nmap <Leader>ot :!alacritty &;disown<cr>:redraw!<cr>
nmap <Leader>or :!alacritty -e fish -C 'ranger' &;disown<cr>:redraw!<cr>
nmap <Leader>fmi :set foldmethod=indent<cr>
vnoremap <Leader>om :OpenMath<CR>
"vnoremap <Leader>os :OpenSym<CR>
"vnoremap <Leader>ow :OpenWa<CR>
"Image disable
nmap <Leader>ida :%s/\(<!-- \)\@<!!\[\(.*\)\?\](.*)\({.*}\)\?/<!-- \0 -->/g<cr> 
nmap <Leader>idl :s/\(<!-- \)\@<!!\[\(.*\)\?\](.*)\({.*}\)\?/<!-- \0 -->/g<cr> 
"Image enable
nmap <Leader>iea :%s/<!-- \(!\[\](.*)\({.*}\)\?\) -->/\1/g<cr>
nmap <Leader>iel :'<,'>s/<!-- \(!\[\](.*)\({.*}\)\?\) -->/\1/g<cr>
source ~/.config/nvim/vimspector.vim
source ~/.config/nvim/coc-config.vim

"To paste macro do ctrl+r ctrl+r <register>

" Fugitive Conflict Resolution
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

:nmap <Leader>cs :!sassc % %:r.css<CR>
autocmd BufWritePost,FileWritePost *.scss :!sassc % %:r.css
autocmd BufWritePost,FileWritePost *.mom :silent :!pdfmom -e % > %:r.pdf
autocmd BufWritePost,FileWritePost *.ms :silent :!groff -e -ms % -T pdf > %:r.pdf
autocmd BufRead,BufNewFile *.pmd setfiletype pandocmd
autocmd BufRead,BufNewFile *.vimclip setfiletype vimclip
au BufWrite *.c,*.cpp :Autoformat
hi clear Conceal
colorscheme onedark

