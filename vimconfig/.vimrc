" ---------- bpayne .vimrc file ----------

" Leader key for custom mapping
let g:mapleader="."

" ----------------------------- SETTINGS ----------------------------- {{{

" Configure initial vim behaviour

" -------------------------- Vim --------------------------

filetype plugin indent on

filetype detect

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

set debug="msg","throw"

set nohlsearch

set foldmethod=manual

syntax on

" }}}

" ----------------------------- PLUGINS ----------------------------- {{{

" External Vim Plugins handled through Vim-Plug Manager

" Inserting plugin requires the following syntax:

" Plug '<GithubAuthor>/<GithubProject>'

" -------------------------------------------------------------

" vim-polygot requires this setting *before* being loaded
let g:polyglot_disabled=['markdown']

call plug#begin('~/.vim/plugged')

" -- General Plugins --
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'LunarWatcher/auto-pairs', {'tag': '*'}
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
" vim-airline requires powerline fonts for symbols
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
" -- Colorscheme Plugins --
Plug 'vim-airline/vim-airline-themes'
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

" Syntax highlighting on-off setting from YCM plugin
let g:ycm_enable_semantic_highlighting=0

let g:AutoPairsMapSpace=0

" Needed for editor config to work properly
let g:EditorConfig_exclude_patterns=['fugitive://.*']

" Prevents bufferline plugin from echoing to command line
let g:bufferline_echo=0

let g:airline_detect_modified=1
let g:airline#extensions#tabline#enabled=0
let g:airline_powerline_fonts=1

" }}} 

" ----------------------------- SCRIPTS ----------------------------- {{{



" }}}

" ----------------------------- MAPPINGS ----------------------------- {{{

" ':mapclear' & ':source' in command line to reset all custom binds

" ---------------- General -----------------

" Save current file 
nnoremap <C-s> :w<CR>

" Run .vimrc file if detectable 
noremap <leader>s :source ~/.vimrc<CR>

" Toggle highlight search 
nnoremap <leader>' :set hlsearch!<CR>:set hlsearch?<CR>

" Retab 
nnoremap re :set noexpandtab<BAR>retab!<CR>

"Split tab 
nnoremap tt :tab split<CR>
" Close tab 
nnoremap rr :tab close<CR>

" Cut 
vnoremap <C-x> "+x
" copy 
vnoremap <C-c> "+y
" Paste 
vnoremap <C-v> "+gP

" Edit current file with superuser permissions 
cnoremap :sed :w<CR>:!sudo tee %

" ----------------- Plugin mappings -----------------

" Vim-Plug shortform
cnoremap :PlugIn :PlugInstall<CR>

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

imap <C-l> <Plug>(YCMToggleSignatureHelp)

" }}}

" ----------------------------- AUTOCOMMANDS ----------------------------- {{{

"-------------------------- PLUGINS -------------------------- 
" vim-bufferline integration with vim-airline
augroup buffer_statusline
	autocmd!
	autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}'
				\ .bufferline#get_status_string()
augroup END

"-------------------------- FILE FORMAT -------------------------- 
" Bash files
augroup filetype_sh
	autocmd!
	autocmd FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" vim files 
augroup filetype_vim
	autocmd!
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
" ----------------------------- AFTER ----------------------------- {{{

" Any settings that may otherwise be overwritten 

" -------------------------- Display -------------------------- 

set noshowmode
set lines=40 columns=165 " Configures initial window size of Vim 
set fillchars=stlnc:-,vert:\|,fold:-,diff:-

if &runtimepath=~"vim-airline"
	let g:airline_theme='base16_3024'
endif

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
