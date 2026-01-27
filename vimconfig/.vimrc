" ---------- bpayne .vimrc file ----------

" Leader key for custom mapping
let g:mapleader="."

" ----------------------------- SETTINGS ----------------------------- {{{

" Configure initial vim behaviour

" -------------------------- Vim --------------------------

filetype on

filetype detect

filetype plugin indent on

set noswapfile

set autochdir

set number relativenumber

set wildmenu wildmode=longest:full,full

set tags=./tags,tags;

set laststatus=2 showtabline=2

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

set list

set shiftround

set smarttab noexpandtab

set tabstop=4 softtabstop=4 shiftwidth=4

set hlsearch

set display=lastline

set wrap

set incsearch

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

" ----------------------------- PLUGINS ----------------------------- {{{

" External Vim Plugins handled through Vim-Plug Manager

" Inserting plugin requires the following syntax:

" Plug '<GithubAuthor>/<GithubProject>'

" -------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" -- General Plugins --
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'max-baz/lightline-ale'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'cdelledonne/vim-cmake'
Plug 'godlygeek/tabular'
Plug 'LunarWatcher/auto-pairs', {'tag': '*'}
Plug 'ycm-core/YouCompleteMe'
" -- Colorscheme Plugins -- 
Plug 'lengarvey/base16-vim'
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

let g:ycm_enable_semantic_highlighting=1

let g:AutoPairsMapSpace=0

" }}} 

" ----------------------------- SCRIPTS ----------------------------- {{{

" ------------------ PLUGIN CONFIG --------------------


if &runtimepath =~ 'lightline.vim'

	function! ShowFileType()
		if !empty(&filetype)
			return &filetype
		else
			return ""
		endif
	endfunction
	
	" Status line configuration via lightline plugin
	let g:lightline = {
	\ 'colorscheme': 'simpleblack',
	\ 'separator': {
	\ 'left': '', 'right': '',
	\ },
	\ 'subseparator': {
	\ 'left': '', 'right': '',
	\ },
	\ 'component': {
	\ 'asciitext': 'Ascii:',
	\ 'columntext': 'Col:',
	\ 'linetext': 'Row:',
	\ },
	\ 'component_function': {
	\ 'filetype': 'ShowFileType',
	\ },
	\ 'component_expand': {
	\ 'linter_checking': 'lightline#ale#checking',
	\ 'linter_infos': 'lightline#ale#infos',
	\ 'linter_warnings': 'lighline#ale#warnings',
	\ 'linter_errors': 'lightline#ale#errors',
	\ 'linter_ok': 'lightline#ale#ok',
	\ },
	\ 'component_type': {
	\ 'linter_checking': 'right',
	\ 'linter_infos': 'right',
	\ 'linter_warnings': 'warning',
	\ 'linter_errors': 'error',
	\ 'linter_ok': 'right',
	\ },
	\ 'active': {
	\ 'left': [ [ 'readonly', 'mode', ],
	\		[ 'filetype', 'relativepath', ],
	\		[ 'fileformat', ] ],
	\ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings',
	\		'linter_infos', 'linter_ok', ],
	\		[ 'percent', 'asciitext', 'charvalue', ],
	\		[ 'columntext', 'column', 'linetext', 'line', ] ] },
	\ }
	
endif

" }}}

" ----------------------------- MAPPINGS ----------------------------- {{{

" ':mapclear' & ':source' in command line to reset all custom binds

" ---------------- General -----------------

" Save current file
nnoremap <C-S> :w<CR>

" Run .vimrc file if detectable
noremap <leader>, :source $MYVIMRC<CR>

" Toggle highlight search
nnoremap <leader>' :set hlsearch! hlsearch?<CR>

" Retab
nnoremap re :set noexpandtab<BAR>retab!<CR>

"Split tab
nnoremap tt :tab split<CR>
" Close tab
nnoremap rr :tab close<CR>

" Cut
vnoremap <C-X> "+x
" copy
vnoremap <C-C> "+y
" Paste
vnoremap <C-V> "+gP

" ----------------- Plugin mappings -----------------

" Vim-Plug shortform
cnoremap :PlugIn :PlugInstall<CR>

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

imap <C-L> <Plug>(YCMToggleSignatureHelp)

" }}}

" ----------------------------- AUTOCOMMANDS ----------------------------- {{{

"-------------------------- FILE FORMAT -------------------------- 
" Bash files
augroup filetype_sh
	autocmd!
	autocmd FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" vim files 
augroup filetype_vim
	autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
	autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" makefiles 
augroup filetype_make
	autocmd!
	autocmd FileType make setlocal noexpandtab nosmarttab noshiftround
	autocmd FileType make setlocal tabstop=0 softtabstop=0 shiftwidth=0
augroup END

" python files 
augroup filetype_py
	autocmd!
	autocmd FileType py setlocal foldmethod=indent
	autocmd FileType python nmap <buffer> <F5> :w<bar>:exec '!python3' shellescape(@%, 1)<CR>
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
	autocmd FileType txt setlocal nolist tabstop=2
	autocmd FileType txt setlocal shiftwidth=2 softtabstop=2
augroup END

" ----------------- Compile & Debug ----------------- 
augroup file_compile
	autocmd!
	
	 " --------- C --------- 
	autocmd FileType c setlocal foldmethod=marker foldmarker={,}
	
	autocmd FileType c setlocal makeprg=gcc\ -Wall\ -Wextra\ -std=c23\ -o\ %<\ %
	
	autocmd FileType c nmap <F4> :w<CR>:make<CR>
	
	autocmd FileType c nmap <F5> :w<CR>:make<CR>:!./%<<CR>
	
	autocmd FileType c nmap <F6> :w<CR>:!./%<<CR>
	
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
	
 augroup END

" }}}

" ----------------------------- AFTER ----------------------------- {{{

" Any settings that may otherwise be overwritten 

" -------------------------- Display -------------------------- 

set noshowmode
set lines=40 columns=165 " Configures initial window size of Vim 
set fillchars=stl:^,stlnc:-,vert:\|,fold:-,diff:-


if has('gui_running')
	set background=dark
	silent! colorscheme base16-3024
	set guiheadroom=45
else
	set t_Co=256
	set background=dark
endif

set showcmd

" }}}
