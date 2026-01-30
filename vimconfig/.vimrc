" ---------- bpayne .vimrc file ----------

" Leader key for custom mapping
let g:mapleader="."

" ----------------------------- SETTINGS ----------------------------- {{{

" Configure initial vim behaviour

" -------------------------- Vim --------------------------

filetype plugin indent on

filetype detect

set lazyredraw

set ttyfast

set noswapfile

set autochdir

set number

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
	" Mouse available in all modes
	set mouse=a
	
	" Regular scrolling
	noremap <ScrollWheelDown> 2<C-E>
	noremap <ScrollWheelUp> 2<C-Y>

	" Shift held while scrolling = Half-page scroll
	noremap <S-ScrollWheelDown> <C-F>
	noremap <S-ScrollWheelUp> <C-B>
	
	" Ctrl held while scrolling = One page scroll
	noremap <C-ScrollWheelDown> <C-D>
	noremap <C-ScrollWheelUp> <C-U>
	
	" Scrolling with insert mode = Escape insert mode
	inoremap <ScrollWheelDown> <esc>
	inoremap <ScrollWheelUp> <esc>
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

" ----------------------------- SCRIPTS ----------------------------- {{{

hi statreplace guibg=#df0000

hi statinsert guibg=#00ff00

hi statnormal guibg=#c6c6c6

hi statvisual guibg=#8700af

hi statcommand guibg=#2178f7

" Return current mode for status line
function! ReturnCurrentMode() abort
	let l:CurrentMode=mode()
	if CurrentMode=='n'
		return "NORMAL"
	elseif CurrentMode=='i'
		return "INSERT"
	elseif CurrentMode=='v'||'V'
		return "VISUAL"
	elseif CurrentMode==''||'b'
		return "V-BLOCK"
	elseif CurrentMode=='R'
		return "REPLACE"
	elseif CurrentMode=='c'
		return "COMMAND"
	endif
endfunction

function! GitBranchName() abort
	let branch = trim(system("git rev-parse --abbrev-ref HEAD 2>/dev/null"))
	return branch
endfunction

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
Plug 'Yggdroot/indentLine'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'LunarWatcher/auto-pairs', {'tag': '*'}
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'Vimjas/vint'
" -- Colorscheme Plugins --
Plug 'jaredgorski/spacecamp'
Plug 'zautumnz/angr.vim'
Plug 'fmoralesc/molokayo'
Plug 'lucasprag/simpleblack'
Plug 'altercation/vim-colors-solarized'

call plug#end()

" -------------------- More Plugin Settings --------------------

" Sets characters to be used by indentLine plugin
let g:indentLine_char_list=['|','¦','┆','┊'] " "

let g:user_emmet_install_=0

let g:fzf_history_dir='/home/bpayne/.local/share/fzf-history' 

" Syntax highlighting on-off setting from YCM plugin
let g:ycm_enable_semantic_highlighting=0

let g:AutoPairsMapSpace=0

" Needed for editor config to work properly
let g:EditorConfig_exclude_patterns=['fugitive://.*']

" Prevents bufferline plugin from echoing to command line
let g:bufferline_echo=0
let g:bufferline_show_bufnr =0

" Turn off git plugin global mappings
let g:fugitive_no_maps=1

let g:ale_fixers={
			\ 'python':[
			\ 'pycln',
			\ 'pyflyby',
			\ ],
			\ }

let g:ale_linter_aliases={
			\ 'vim': ['vint'],
			\ }

call ale#Set('vim_vint_show_style_issues',1)

" }}} 

" ----------------------------- MAPPINGS ----------------------------- {{{

" ':mapclear' & ':source' in command line to reset all custom binds

" ---------------- General -----------------

" Save current file 
nnoremap <F3> :w<CR>

" Run .vimrc file if detectable and :edit to refresh
nnoremap <leader>s :source ~/.vimrc<CR>:edit %<CR>

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
" augroup buffer_statusline
"	autocmd!
"	autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}'
"				\ .bufferline#get_status_string()
" augroup END

"-------------------------- FILE FORMAT -------------------------- 


" vim files 
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
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
	autocmd FileType python nnoremap <buffer> <F5> :w<bar>:exec '!python3' shellescape(@%, 1)<CR>
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
	" For C and C++, <F4> is compile, <F5> is compile and run, and <F6> is run.
	autocmd!
	 " --------- C --------- 
	autocmd FileType c setlocal foldmethod=marker foldmarker={,}
	
	autocmd FileType c setlocal makeprg=gcc\ -Wall\ -Wextra\ -std=c23\ -o\ %<\ %
	
	autocmd FileType c nnoremap <F4> :w<CR>:make<CR>
	
	autocmd FileType c nnoremap <F5> :w<CR>:make<CR>:!./%<<CR>
	
	autocmd FileType c nnoremap <F6> :w<CR>:!./%<<CR>
	
	 " --------- C++ --------- 
	autocmd FileType cpp setlocal foldmethod=marker foldmarker={,}
	
	autocmd FileType cpp setlocal makeprg=g++\ -Wall\ -Wextra\ -Weffc++\
				\ -Wsign-conversion\ -Wconversion\ -ggdb\ -pedantic-errors\ -std=c++23\ -o\ %<\ %
	
	autocmd FileType cpp nmap <F4> :w<CR>:make<CR>
	
	autocmd FileType cpp nmap <F5> :w<CR>:make<CR>:!./%<<CR>
	
	autocmd FileType cpp nmap <F6> :w<CR>:!./%<<CR>
	
	 " --------- C# --------- 
	autocmd FileType cs setlocal makeprg=dotnet\ build\
				\ property:GenerateFullPaths=true\
				\ verbosity:quiet\
				\ errorformat=%f(%l\,%c):\ %t%n\ %m\
 augroup END

" }}}

" ----------------------------- STATUS LINE ----------------------------- {{{


" Clear status line
set statusline=

set statusline+=\ %{%ReturnCurrentMode()%}\ \|
" File type
set statusline+=%(\ %Y\ \|%)
" File path
set statusline+=%(\ %F%(\ %m%)%(\ \[%{%GitBranchName()%}]%)\ \|%)
" File flags
set statusline+=%(\ %R\ %H\ %W\ \|%)

" Right-align all components after this
set statusline+=%=

set statusline+=%(\|\ %{&fileencoding?&fileencoding:&encoding}\ %)
" Column position of cursor
set statusline+=%(\|\ \Col:\ %c%V\,%)
" Current line in file
set statusline+=%(\ %l%)
" Amount of lines in buffer
set statusline+=%(\/%L\ %)
" Lines passed in file as percentage
set statusline+=\|\ %p%%\ 

" }}}

" ----------------------------- AFTER ----------------------------- {{{

" Any settings that may otherwise be overwritten 

" -------------------------- Display -------------------------- 

set noshowmode

set fillchars=stlnc:-,vert:\|,fold:-,diff:-


if has('gui_running')
	set background=dark
	set lines=55 columns=999
	silent! colorscheme lunaperche
	set guiheadroom=45
else
	set t_Co=256
	set background=dark
	silent! colorscheme lunaperche
endif

set showcmd

" }}}
