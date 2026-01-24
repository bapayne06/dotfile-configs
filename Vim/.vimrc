"        _                    
" __   _(_)_ __ ___  _ __ ___ 
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__ 
" (_)_/ |_|_| |_| |_|_|  \___|
" ----------------------------

" Leader key for custom mapping
let g:mapleader="."

" -------------------------- SETTINGS -------------------------- {{{

" Configure overall Vim behaviour

" -------------------------- Vim --------------------------

filetype on
filetype plugin indent on
set autochdir
set number
set relativenumber
set wildmenu
set wildmode=longest:full,full
set tags=./tags,tags;
set laststatus=2
set showtabline=2
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
set shiftwidth=4
set smarttab expandtab
set tabstop=4 softtabstop=4
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

packadd! matchit
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
" -- Colorscheme Plugins -- 
Plug 'zautumnz/angr.vim'
Plug 'andreasvc/vim-256noir'
Plug 'w0ng/vim-hybrid'
Plug 'joshdick/onedark.vim'
Plug 'fmoralesc/molokayo'
Plug 'lucasprag/simpleblack'
Plug 'puremorning/vimspector'
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

" vim files
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
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
        \	'linter_checking': 'lightline#ale#checking',
        \	'linter_infos': 'lightline#ale#infos',
        \	'linter_warnings': 'lighline#ale#warnings',
        \	'linter_errors': 'lightline#ale#errors',
        \	'linter_ok': 'lightline#ale#ok',
        \ },
        \ 'component_type': {
        \	'linter_checking': 'right',
        \	'linter_infos': 'right',
        \	'linter_warnings': 'warning',
        \	'linter_errors': 'error',
        \	'linter_ok': 'right',
        \ },
        \ 'active': {
        \   'left': [ [ 'readonly', 'mode', ],
        \           [ 'filetype', 'absolutepath', ],
        \           [ 'fileformat', ] ],
        \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings',
        \   'linter_infos', 'linter_ok', ],
        \			[ 'percent', 'asciitext', 'charvalue', ],
        \           [ 'column', 'line', ] ] },
        \ }
endif

" }}}

" -------------------------- MAPPINGS -------------------------- {{{

" Used to refresh Vim settings after reconfiguring them.
" (instance must know path to settings)
nnoremap <leader>, :<esc>:source $MYVIMRC<CR>

" Used for toggling text highlight on and off.
nnoremap <leader>h :set hlsearch! hlsearch?<CR>

" Allows cut, copy and paste in visual mode with standard mappings
vnoremap <C-x> "+x
vnoremap <C-c> "+y
vnoremap <C-d> "+gP
inoremap <C-d> :<esc> "+gP

" ----------------- Plugin / External mappings -----------------
" NERDTree Plugin shortcuts.
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

augroup filetype_py
	autocmd!
	" Maps F5 key to compile and run python script when inside python file.
	autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
	autocmd FileType python imap <buffer> <F5> :<esc><CR>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
augroup END
augroup filetype_c
    autocmd!
    autocmd FileType cpp map <buffer> <F9> :w<CR>:exec '!gcc' shellescape(@%, 1)<CR>
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
	let g:hybrid_custom_term_colors=1
	let g:hybrid_reduced_contract=1
	colorscheme simpleblack 
else
	set t_Co=256
endif

" }}}
