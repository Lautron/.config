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
:filetype on

source ~/.config/nvim/coc-config.vim
"Install vim plug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>rp :w <bar> :!source ./venv/bin/activate.fish & python %
nmap <Leader>rc :w <bar> :! ./%<
nmap <Leader>cc :w <bar> :! gcc -Wall -Wextra -std=c99 -g % -o %< <CR>
nmap <Leader>r+ :w <bar> :! g++ -g -O2 -std=gnu++17 -static -o %< % <CR>
nmap <Leader>c+ :w <bar> :! g++ -std=c++11 -g -O2 -Wconversion -Wshadow -Wall -Wextra -D_GLIBCXX_DEBUG -o %< % <CR>
nmap <Leader>cl :w <bar> :!pandoc -f markdown -t latex "%" -o "%:r.pdf"<CR>
nmap <Leader>p "+p<CR>
nmap <Leader>op :!zathura '%<'.pdf&;disown<cr>:redraw!<cr>
nmap <Leader>ot :!alacritty &;disown<cr>:redraw!<cr>
nmap <Leader>tyu {<bar>yi<bar>}<bar>p
nmap <Leader>tys kyi<bar>jpF}hA<bar><Esc>
nmap <Leader>yuq ?wp\.2f.lvt$y/equivop
source ~/.config/nvim/vimspector.vim
"nmap <Leader>as ?sigma<CR>yy}kpf_l
"nmap <Leader>al ?ell<CR>f{lyw}i$\ell_{}<Esc>PA\quad $\<Esc>2h
let @l=':s/  /\\quad /geI$\ell_{1}\quad A$\j0'
"To paste macro do ctrl+r ctrl+r <register>

:nmap <Leader>cs :!sassc % %:r.css<CR>
autocmd BufWritePost,FileWritePost *.scss :!sassc % %:r.css
autocmd BufWritePost,FileWritePost *.mom :silent :!pdfmom -e % > %:r.pdf
autocmd BufWritePost,FileWritePost *.ms :silent :!groff -e -ms % -T pdf > %:r.pdf
autocmd BufRead,BufNewFile *.pmd setfiletype pandocmd
autocmd BufRead,BufNewFile *.vimclip setfiletype vimclip
"Make a debug mode for pandoc
"autocmd BufWritePost,FileWritePost *.pmd :silent :!pandoc -f markdown -t latex "%" -o "%:r.pdf"
"autocmd BufWritePost,FileWritePost *.tex :silent :!pdflatex %
au BufWrite *.c,*.cpp :Autoformat
hi clear Conceal
colorscheme onedark
