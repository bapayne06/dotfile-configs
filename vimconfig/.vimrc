"        _                    
" __   _(_)_ __ ___  _ __ ___ 
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__ 
" (_)_/ |_|_| |_| |_|_|  \___|
" ----------------------------

" Leader key for custom mapping
let g:mapleader="."

" -------------------------- SETTINGS -------------------------- {{{

" Configure initial vim behaviour

" -------------------------- Vim --------------------------

filetype on

filetype plugin indent on

set noswapfile

set autochdir

set number relativenumber

set wildmenu wildmode=longest:full,full

set tags=./tags,tags;

set laststatus=2 showtabline=2

set showcmd

set nocompatible

set confirm 

if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000 
endif

if has('mouse')
    set mouse=a
endif

" -------------------------- Files & Text --------------------------

set linespace=2

set shiftround

set smarttab expandtab

set tabstop=4 softtabstop=4 shiftwidth=4

set hlsearch

set display=lastline

set wrap

set incsearch

set list

set ignorecase

set smartcase

set autoindent

set cursorline

set ruler

set encoding=utf-8

set debug="msg","throw"

set foldmethod=manual

syntax on

" }}}

" -------------------------- PLUGINS -------------------------- {{{

" External Vim Plugins handled through Vim-Plug Manager

" Inserting plugin requires the username &&
" project name of the github repo as found in 
" it's github link.

call plug#begin('~/.vim/plugged')
" -- General Plugins --
Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdtree'

Plug 'Yggdroot/indentLine'

Plug 'mattn/emmet-vim'

Plug 'itchyny/lightline.vim'

Plug 'max-baz/lightline-ale'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'cdelledonne/vim-cmake'


" -- Colorscheme Plugins -- 

Plug 'zautumnz/angr.vim'

Plug 'andreasvc/vim-256noir'

Plug 'w0ng/vim-hybrid'

Plug 'joshdick/onedark.vim'

Plug 'fmoralesc/molokayo'

Plug 'lucasprag/simpleblack'

call plug#end()

" -------------------------- More Plugin Settings --------------------------

" Sets characters to be used by indentLine plugin
let g:indentLine_char_list=['|','¦','┆','┊'] " "

" emmet-vim plugin settings.
let g:user_emmet_install_=0

let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['__pycache__', '.swp', '.swo']

" Enable per-command history for fzf
let g:fzf_history_dir='/home/bpayne/.local/share/fzf-history' 

" }}} 

" -------------------------- SCRIPTING -------------------------- {{{

" ------------------------ PLUGIN CONFIG ------------------------

" NERDTree plugin
if &runtimepath =~ 'nerdtree'
    augroup NERD
        autocmd!
        " Start NERDTree when Vim starts alongside a directory argument.
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc()==1 && isdirectory(argv()[0]) && !exists('s:std_in') |
                            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
    augroup END
endif

" Set fzf plugin display colours
if &runtimepath =~ 'fzf.vim'
    let g:fzf_colors=  
    \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'query':   ['fg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'], }
endif

function! FiletypeLightline()
    let filetype = '%{&ft!=#""?&ft:" "}'
endfunction

if &runtimepath =~ 'lightline.vim' 
    " Status line configuration via lightline plugin
    let g:lightline = {
        \ 'colorscheme': 'simpleblack',
        \ 'separator': {
        \ 'left': '|', 'right': '|',
        \ },
        \ 'component': {
        \ 'asciitext': 'Ascii:',
        \ },
        \ 'component_function': {
        \ 'filetype': 'FiletypeLightline',
        \ },
        \ 'component_expand': {
        \   'linter_checking': 'lightline#ale#checking',
        \   'linter_infos': 'lightline#ale#infos',
        \   'linter_warnings': 'lighline#ale#warnings',
        \   'linter_errors': 'lightline#ale#errors',
        \   'linter_ok': 'lightline#ale#ok',
        \ },
        \ 'component_type': {
        \   'linter_checking': 'right',
        \   'linter_infos': 'right',
        \   'linter_warnings': 'warning',
        \   'linter_errors': 'error',
        \   'linter_ok': 'right',
        \ },
        \ 'active': {
        \   'left': [ [ 'readonly', 'mode', ],
        \           [ 'filetype', 'absolutepath', ],
        \           [ 'fileformat', ] ],
        \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings',
        \   'linter_infos', 'linter_ok', ],
        \           [ 'percent', 'asciitext', 'charvalue', ],
        \           [ 'column', 'line', ] ] },
        \ }
endif

" }}}

" -------------------------- MAPPINGS -------------------------- {{{

" ':mapclear' followed by a command family such as insert mode to 
"  remove all mappings for that family

" ---------------- General -----------------

" Save current file
nnoremap <C-s> :w<CR>

" Run .vimrc file if detectable
nnoremap <leader>, :source $MYVIMRC<CR>

" Toggle highlight search
nnoremap <leader>h :set hlsearch! hlsearch?<CR>

" Retab
nnoremap re :retab<CR>

" Insert mode escape bind



" Cut
noremap <C-x> "+x
" Copy
vnoremap <C-c> "+y
" Paste
vnoremap <C-v> "+gP
" Paste (Insert mode)
nnoremap <C-v> "+gP

" ----------------- Plugin mappings -----------------

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>



" }}}
 
" -------------------------- AUTOCOMMANDS -------------------------- {{{

"-------------------------- FORMATTING -------------------------- 

" vim files
augroup filetype_vim:
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}} 
    autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" makefiles
augroup filetype_make
    autocmd!
    autocmd FileType make setlocal noexpandtab softabstop=0
augroup END

" python files
augroup filetype_py
    autocmd! 
    autocmd FileType py setlocal foldmethod=indent
augroup END

" LaTeX files
augroup TexTags
    autocmd!
    autocmd filetype tex let b:latex=1
augroup end

" html and css files
augroup html_css
    autocmd!
    autocmd FileType html,css EmmetInstall
augroup END

" ----------------- Compile & Debug -----------------

augroup file_compile
    autocmd!
    
  " --------- specific settings --------- 
    autocmd FileType python nmap <buffer> <F5> :w<bar>:exec '!python3' shellescape(@%, 1)<CR>


    autocmd FileType python imap <buffer> <F5> :<esc>:w<bar>:exec '!python3' shellescape(@%, 1)<CR>


  " --------- c++ specific settings ---------
    autocmd FileType cpp setlocal makeprg=g++\ -Wall\ -Wextra\ -std=c++23\ -o\ %<\ %
    
    " Make/Build
    autocmd FileType cpp nmap <F4> :w<CR>:make<CR>

    " Make and Run
    autocmd FileType cpp nmap <F5> :w<CR>:make<CR>:!./%<<CR>
  
    " Run
   autocmd FileType cpp nmap <F6> :w<CR>:!./%<<CR>

augroup END
" }}}

" -------------------------- AFTER SETTINGS -------------------------- {{{

" Put any settings that may otherwise be overwritten here 

" -------------------------- Display --------------------------
set noshowmode
set lines=40 columns=165 " Configures initial window size of Vim
set fillchars=stl:^,stlnc:-,vert:\|,fold:-,diff:-

if has('gui_running')
    set background=dark
    set guiheadroom=45
    colorscheme simpleblack 
else
    set t_Co=256
    set background=dark
    colorscheme simpleblack
endif

" }}}
