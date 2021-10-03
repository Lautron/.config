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
:filetype on

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

"Plug 'prurigro/vim-markdown-concealed'
Plug 'honza/vim-snippets'
"Plug 'chrisbra/csv.vim'
Plug 'mechatroner/rainbow_csv'

call plug#end()
let mapleader = " "
let NERDTreeQuitOnOpen=1
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>rp :w <bar> :! python %<CR>
nmap <Leader>cl :w <bar> :!pandoc -f markdown -t latex % -o %:r.pdf<CR>
nmap <Leader>y "+y<CR>
nmap <Leader>p "+p<CR>

:nmap <Leader>cs :!sassc % %:r.css<CR>
autocmd BufWritePost,FileWritePost *.scss :!sassc % %:r.css
autocmd BufWritePost,FileWritePost *.mom :silent :!pdfmom -e % > %:r.pdf
autocmd BufWritePost,FileWritePost *.ms :silent :!groff -e -ms % -T pdf > %:r.pdf
autocmd BufRead,BufNewFile *.pmd setfiletype pandocmd
autocmd BufRead,BufNewFile *.vimclip setfiletype vimclip
"Make a debug mode for pandoc
autocmd BufWritePost,FileWritePost *.pmd :silent :!pandoc -f markdown -t latex % -o %:r.pdf
autocmd BufWritePost,FileWritePost *.tex :silent :!pdflatex %
hi clear Conceal
colorscheme onedark
