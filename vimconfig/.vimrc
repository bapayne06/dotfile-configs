"    db    db d888888b .88b  d88. d8888b.  .o88b.    
"    88    88   `88'   88'YbdP`88 88  `8D d8P  Y8    
"    Y8    8P    88    88  88  88 88oobY' 8P         
"    `8b  d8'    88    88  88  88 88`8b   8b         
" db  `8bd8'    .88.   88  88  88 88 `88. Y8b  d8    
" VP    YP    Y888888P YP  YP  YP 88   YD  `Y88P'    
"                                                    
"                                                    
"  .o88b.  .d88b.  d8b   db d88888b d888888b  d888b  
" d8P  Y8 .8P  Y8. 888o  88 88'       `88'   88' Y8b 
" 8P      88    88 88V8o 88 88ooo      88    88      
" 8b      88    88 88 V8o88 88~~~      88    88  ooo 
" Y8b  d8 `8b  d8' 88  V888 88        .88.   88. ~8~ 
"  `Y88P'  `Y88P'  VP   V8P YP      Y888888P  Y888P  

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

set softtabstop=4 shiftwidth=4

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

"set debug="msg","throw"

set foldmethod=manual

syntax on

" }}}

" -------------------------- PLUGINS -------------------------- {{{

" External Vim Plugins handled through Vim-Plug Manager

" Inserting plugin requires the username &&
" project name of the github repo as found in 
" it's github link.

" -------------------------------------------------------------

call plug#begin('~/.vim/plugged')
" -- General Plugins --

Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdtree'

Plug 'Yggdroot/indentLine'

Plug 'mattn/emmet-vim'

Plug 'itchyny/lightline.vim'

Plug 'max-baz/lightline-ale'

Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

Plug 'cdelledonne/vim-cmake'

Plug 'ycm-core/YouCompleteMe'

Plug 'rdnetto/YCM-Generator'

Plug 'lengarvey/base16-vim'

" -- Colorscheme Plugins -- 

Plug 'zautumnz/angr.vim'

Plug 'chriskempson/base16-vim'

Plug 'fmoralesc/molokayo'

Plug 'lucasprag/simpleblack'

Plug 'altercation/vim-colors-solarized'

call plug#end()

" -------------------- More Plugin Settings --------------------

" Sets characters to be used by indentLine plugin
let g:indentLine_char_list=['|','¦','┆','┊'] " "

let g:user_emmet_install_=0

let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['__pycache__', '.swp', '.swo']

let g:fzf_history_dir='/home/bpayne/.local/share/fzf-history' 

if version >= 902
    let b:ycm_enable_inlay_hints=1
endif

" }}} 

" -------------------------- SCRIPTING -------------------------- {{{

" ------------------ PLUGIN CONFIG --------------------


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

" ':mapclear' in command line to unset all custom binds

" ---------------- General -----------------

" Save current file
nnoremap <C-s> :w<CR>
vnoremap <C-s> :w<CR>

" Run .vimrc file if detectable
nnoremap <leader>, :silent source $MYVIMRC<CR>
vnoremap <leader>, :silent source $MYVIMRC<CR>

" Toggle highlight search
nnoremap <leader>h :set hlsearch! hlsearch?<CR>
vnoremap <leader>h :set hlsearch! hlsearch?<CR>

" Retab
nnoremap re :retab<CR>

" Close focused buffer
nnoremap tt :close<CR>

" Vim-Plug
cnoremap :PlugIn :PlugInstall<CR>

" Cut
cnoremap <C-x> "+x
nnoremap <C-x> "+x
" Copy
vnoremap <C-c> "+y
nnoremap <C-c> "+y
" Paste
vnoremap <C-v> "+gP
nnoremap <C-v> "+gP

" ----------------- Plugin mappings -----------------

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

nnoremap <leader>c :YcmGenerateConfig<CR>

" }}}
 
" -------------------------- AUTOCOMMANDS -------------------------- {{{

"-------------------------- FILE FORMAT -------------------------- 

" vim files 
augroup filetype_vim:
  autocmd!
  
  autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
  
  autocmd FileType vim setlocal smarttab expandtab shiftround
  
  autocmd FileType vim setlocal softtabstop=2 shiftwidth=2
augroup END

" makefiles 
augroup filetype_make
  autocmd!

  autocmd FileType make setlocal noexpandtab nosmarttab noshiftround
  
  autocmd FileType make setlocal softtabstop=0 shiftwidth=0
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
  
  autocmd FileType html EmmetInstall
augroup END

augroup filetype_txt
  autocmd!
  
  autocmd FileType txt setlocal nolist softtabstop=2
  
  autocmd FileType txt setlocal shiftwidth=2
augroup END

" ----------------- Compile & Debug ----------------- 

augroup file_compile
  autocmd!
  " --------- Python --------- 
  autocmd FileType python nmap <buffer> <F5> :w<bar>:exec '!python3' shellescape(@%, 1)<CR>
  
  " --------- C --------- 
  
  autocmd FileType cc setlocal foldmethod=marker foldmarker={,}
  
  autocmd FileType cc setlocal makeprg=gcc\ -Wall\ -Wextra\ -std=c23\ -o\ %<\ %
  
  autocmd FileType cc nmap <F4> :w<CR>:make<CR>
  
  autocmd FileType cc nmap <F5> :w<CR>:make<CR>:!./%<<CR>
  
  autocmd FileType cc nmap <F6> :w<CR>:!./%<<CR>
  
  " --------- C++ --------- 
  
  autocmd FileType cxx setlocal foldmethod=marker foldmarker={,}
  
  autocmd FileType cxx setlocal makeprg=g++\ -Wall\ -Wextra\ -std=c++23\ -o\ %<\ %
  
  autocmd FileType cxx nmap <F4> :w<CR>:make<CR>
  
  autocmd FileType cxx nmap <F5> :w<CR>:make<CR>:!./%<<CR>
  
  autocmd FileType cxx nmap <F6> :w<CR>:!./%<<CR>
  
  " --------- C# --------- 
  
  autocmd FileType cs setlocal makeprg=dotnet\ build\
                \ property:GenerateFullPaths=true\
                \ verbosity:quiet\
                \ errorformat=%f(%l\,%c):\ %t%n\ %m\
  
  autocmd FileType cs nmap <F4> :w<CR>:!dotnet run<CR>
  
  autocmd FileType cs nmap <F5> :w<CR>:!dotnet build<CR>
augroup END

" }}}

" -------------------------- AFTER SETTINGS -------------------------- {{{

" Put any settings that may otherwise be overwritten here 

" -------------------------- Display -------------------------- 

set noshowmode
set lines=40 columns=165 " Configures initial window size of Vim 
set fillchars=stl:^,stlnc:-,vert:\|,fold:-,diff:-

colorscheme base16-gigavolt

if has('gui_running')
    set background=dark
    set guiheadroom=45
else
    set background=dark
endif

" }}}
