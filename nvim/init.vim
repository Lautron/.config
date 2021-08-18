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
Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=2
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

Plug 'honza/vim-snippets'

call plug#end()
let mapleader = " "
let NERDTreeQuitOnOpen=1

nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>rp :w <bar> :! python %<CR>
nmap <Leader>y "+y<CR>
nmap <Leader>p "+p<CR>

:nmap <Leader>cs :!sassc % %:r.css<CR>
autocmd BufWritePost,FileWritePost *.scss :!sassc % %:r.css
autocmd BufWritePost,FileWritePost *.mom :silent :!pdfmom -e % > %:r.pdf
autocmd BufWritePost,FileWritePost *.ms :silent :!groff -e -ms % -T pdf > %:r.pdf
autocmd BufRead,BufNewFile *.pmd setfiletype pandocmd
autocmd BufRead,BufNewFile *.vimclip setfiletype vimclip
autocmd BufWritePost,FileWritePost *.pmd :silent :!pandoc -f markdown -t latex % -o %:r.pdf
autocmd BufWritePost,FileWritePost *.tex :silent :!pdflatex %
hi clear Conceal
colorscheme onedark
